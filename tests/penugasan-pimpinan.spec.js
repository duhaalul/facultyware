const { test, expect } = require('@playwright/test');

test.describe('Penugasan (Pimpinan)', () => {
  test.beforeEach(async ({ context, page }) => {
    await context.clearCookies();
    await page.goto('/login');
    await page.locator('input[name="username"]').fill('Shidiq Maihendra');
    await page.locator('input[name="password"]').fill('pimpinan123');
    await page.locator('button[type="submit"]').click();
    await page.waitForURL(/.*dashboard/);
  });

  test('pimpinan bisa melihat daftar penugasan', async ({ page }) => {
    await page.goto('/tugas');
    await expect(page.locator('h2')).toContainText('Kelola Penugasan');
    await expect(page.locator('table')).toBeVisible();
  });

  test('pimpinan bisa menambah penugasan baru', async ({ page }) => {
    const uniqueTitle = 'Test Tugas Playwright ' + Date.now();
    await page.goto('/tugas/create');
    await page.fill('input[name="title"]', uniqueTitle);
    await page.fill('textarea[name="description"]', 'Deskripsi otomatis dari Playwright');
    await page.selectOption('select[name="assigned_to"]', { index: 1 });
    await page.selectOption('select[name="priority"]', 'medium');
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/tugas$/);
    await expect(page.locator(`text=${uniqueTitle}`).first()).toBeVisible();
  });

  test('pimpinan bisa melihat detail penugasan', async ({ page }) => {
    await page.goto('/tugas');
    await page.locator('table tbody tr').first().click();
    await page.waitForURL(/.*\/detail/);
    await expect(page.locator('h2')).toBeVisible();
    await expect(page.locator('p:has-text("Detail Penugasan")')).toBeVisible();
  });

  test('pimpinan bisa edit penugasan', async ({ page }) => {
    const uniqueTitle = 'Edit Tugas Playwright ' + Date.now();
    await page.goto('/tugas/create');
    await page.fill('input[name="title"]', uniqueTitle);
    await page.fill('textarea[name="description"]', 'Deskripsi sebelum diedit');
    await page.selectOption('select[name="assigned_to"]', { index: 1 });
    await page.selectOption('select[name="priority"]', 'low');
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/tugas$/);

    await page.locator('table tbody tr').first().click();
    await page.waitForURL(/.*\/detail/);

    // Klik link Edit yang spesifik (bukan teks h2)
    await page.locator('a.btn:has-text("Edit")').click();
    await page.waitForURL(/.*\/edit/);

    const updatedTitle = 'Updated Tugas ' + Date.now();
    await page.locator('input[name="title"]').fill(updatedTitle);
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/tugas$/);
    await expect(page.locator(`text=${updatedTitle}`).first()).toBeVisible();
  });

  test('pimpinan bisa hapus penugasan', async ({ page }) => {
    const uniqueTitle = 'Hapus Tugas Playwright ' + Date.now();
    await page.goto('/tugas/create');
    await page.fill('input[name="title"]', uniqueTitle);
    await page.fill('textarea[name="description"]', 'Tugas yang akan dihapus');
    await page.selectOption('select[name="assigned_to"]', { index: 1 });
    await page.selectOption('select[name="priority"]', 'low');
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/tugas$/);

    await page.locator('table tbody tr').first().click();
    await page.waitForURL(/.*\/detail/);

    // Klik Edit dulu lalu cari URL id tugas
    const url = page.url();
    const id = url.match(/\/tugas\/(\d+)\/detail/)?.[1];

    // Langsung navigate ke halaman tugas, cari form hapus pakai id
    await page.goto('/tugas');
    page.on('dialog', dialog => dialog.accept());
    await page.locator(`form[action="/tugas/${id}/delete"] button`).click();
    await page.waitForURL(/.*\/tugas$/);
    await expect(page.locator(`text=${uniqueTitle}`)).not.toBeVisible();
  });

  test('pimpinan bisa monitoring penugasan', async ({ page }) => {
    await page.goto('/dashboard/monitoring');
    await expect(page.locator('h2')).toContainText('Monitoring Penugasan');
    await expect(page.locator('table')).toBeVisible();
  });
});
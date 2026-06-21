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

  test('pimpinan bisa melihat daftar penugasan', async ({ page }) => {
    await page.goto('/tugas');
    await expect(page.locator('h2')).toContainText('Kelola Penugasan');
    await expect(page.locator('table')).toBeVisible();
  });
});
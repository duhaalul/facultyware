const { test, expect } = require('@playwright/test');

test.describe('Logbook (Pimpinan)', () => {
  test.beforeEach(async ({ context, page }) => {
    await context.clearCookies();
    await page.goto('/login');
    await page.locator('input[name="username"]').fill('Shidiq Maihendra');
    await page.locator('input[name="password"]').fill('pimpinan123');
    await page.locator('button[type="submit"]').click();
    await page.waitForURL(/.*dashboard/);
  });

  test('pimpinan bisa melihat logbook pegawai', async ({ page }) => {
    await page.goto('/logbook/pimpinan');
    await expect(page.locator('h2')).toContainText('Logbook Pegawai');
    await expect(page.locator('.item-list')).toBeVisible();
  });

  test('pimpinan bisa filter logbook berdasarkan pegawai', async ({ page }) => {
    await page.goto('/logbook/pimpinan');
    await page.selectOption('select[name="employee_id"]', { index: 1 });
    await page.locator('button:has-text("Filter")').click();
    await page.waitForLoadState('networkidle');
    await expect(page.locator('h2')).toContainText('Logbook Pegawai');
  });

  test('pimpinan bisa approve logbook', async ({ page }) => {
    await page.goto('/logbook/pimpinan');

    const setujuiBtn = page.locator('.item-row').filter({
      has: page.locator('text=Pending')
    }).locator('button:has-text("Setujui")').first();

    if (await setujuiBtn.isVisible()) {
      await setujuiBtn.click();
      await page.waitForURL(/.*\/logbook\/pimpinan/);
      await expect(page.locator('text=Logbook disetujui')).toBeVisible({ timeout: 10000 });
    } else {
      console.log('Tidak ada logbook pending untuk disetujui');
    }
  });

  test('pimpinan bisa tolak logbook', async ({ page }) => {
    await page.goto('/logbook/pimpinan');

    const itemPending = page.locator('.item-row').filter({
      has: page.locator('text=Pending')
    }).first();

    if (await itemPending.isVisible()) {
      await itemPending.locator('input[name="catatan"]').fill('Mohon diperbaiki deskripsinya');
      await itemPending.locator('button:has-text("Tolak")').click();
      await page.waitForURL(/.*\/logbook\/pimpinan/);
      await expect(page.locator('text=Logbook ditolak')).toBeVisible({ timeout: 10000 });
    } else {
      console.log('Tidak ada logbook pending untuk ditolak');
    }
  });

  test('pimpinan bisa export logbook ke PDF', async ({ page }) => {
    const downloadPromise = page.waitForEvent('download');
    await page.goto('/logbook/pimpinan');
    await page.locator('a:has-text("Export PDF")').click();
    const download = await downloadPromise;
    expect(download.suggestedFilename()).toContain('.pdf');
  });
});
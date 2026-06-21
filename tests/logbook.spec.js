const { test, expect } = require('@playwright/test');

test.describe('Logbook (Pegawai)', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/login');
    await page.fill('input[name="username"]', 'Duha Alul Bariq');
    await page.fill('input[name="password"]', 'pegawai123');
    await page.click('button[type="submit"]');
    await expect(page).toHaveURL(/.*dashboard/);
  });

  test('pegawai bisa menambah logbook', async ({ page }) => {
    await page.goto('/logbook/create');
    await page.fill('textarea[name="description"]', 'Logbook otomatis dari Playwright test');
    await page.click('button[type="submit"]');

    await expect(page).toHaveURL(/.*\/logbook$/);
    await expect(page.locator('text=Logbook berhasil ditambahkan')).toBeVisible();
  });

  test('pegawai bisa melihat daftar logbook', async ({ page }) => {
    await page.goto('/logbook');
    await expect(page.locator('h2')).toContainText('Logbook Saya');
  });
});
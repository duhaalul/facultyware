const { test, expect } = require('@playwright/test');
const path = require('path');
const fs = require('fs');

test.describe('Penugasan (Pegawai)', () => {
  test.beforeEach(async ({ context, page }) => {
    await context.clearCookies();
    await page.goto('/login');
    await page.locator('input[name="username"]').fill('Duha Alul Bariq');
    await page.locator('input[name="password"]').fill('pegawai123');
    await page.locator('button[type="submit"]').click();
    await page.waitForURL(/.*dashboard/);
  });

  test('pegawai bisa melihat daftar tugas', async ({ page }) => {
    await page.goto('/tugas/pegawai');
    await expect(page.locator('h2')).toContainText('Tugas Saya');
    await expect(page.locator('.item-list')).toBeVisible();
  });

  test('pegawai bisa melihat detail tugas', async ({ page }) => {
    await page.goto('/tugas/pegawai');
    await page.locator('.item-row').first().click();
    await page.waitForURL(/.*\/detail/);
    await expect(page.locator('h2')).toBeVisible();
    await expect(page.locator('p:has-text("Detail Penugasan")')).toBeVisible();
  });

  test('pegawai bisa mengumpulkan tugas', async ({ page }) => {
    await page.goto('/tugas/pegawai');

    const tugasBelumSelesai = page.locator('.item-row').filter({
      hasNot: page.locator('.badge-success')
    }).first();

    await tugasBelumSelesai.click();
    await page.waitForURL(/.*\/detail/);

    const kumpulkanBtn = page.locator('a:has-text("Kumpulkan Tugas")');
    if (await kumpulkanBtn.isVisible()) {
      await kumpulkanBtn.click();
      await page.waitForURL(/.*\/submit/);

      await page.fill('textarea[name="description"]', 'Hasil kerja otomatis dari Playwright ' + Date.now());

      const filePath = path.join(__dirname, 'dummy-test.txt');
      fs.writeFileSync(filePath, 'File dummy untuk Playwright test');
      await page.locator('input[name="attachment"]').setInputFiles(filePath);

      await page.click('button[type="submit"]');
      await page.waitForLoadState('networkidle', { timeout: 15000 });

      await expect(page.locator('h2')).toBeVisible({ timeout: 10000 });

      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    } else {
      console.log('Tidak ada tugas yang bisa dikumpulkan');
    }
  });
});
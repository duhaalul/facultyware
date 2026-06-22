const { test, expect } = require('@playwright/test');
const path = require('path');
const fs = require('fs');

test.describe('Logbook (Pegawai)', () => {
  test.beforeEach(async ({ context, page }) => {
    await context.clearCookies();
    await page.goto('/login');
    await page.locator('input[name="username"]').fill('Duha Alul Bariq');
    await page.locator('input[name="password"]').fill('pegawai123');
    await page.locator('button[type="submit"]').click();
    await page.waitForURL(/.*dashboard/);
  });

  test('pegawai bisa melihat daftar logbook', async ({ page }) => {
    await page.goto('/logbook');
    await expect(page.locator('h2')).toContainText('Logbook Saya');
    await expect(page.locator('.item-list')).toBeVisible();
  });

  test('pegawai bisa menambah logbook', async ({ page }) => {
    await page.goto('/logbook/create');
    await page.fill('textarea[name="description"]', 'Logbook otomatis dari Playwright ' + Date.now());
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/logbook$/);
    await expect(page.locator('text=Logbook berhasil ditambahkan')).toBeVisible({ timeout: 10000 });
  });

  test('pegawai bisa menambah logbook dengan lampiran', async ({ page }) => {
    await page.goto('/logbook/create');

    const uniqueDesc = 'Logbook dengan lampiran ' + Date.now();
    await page.fill('textarea[name="description"]', uniqueDesc);

    const filePath = path.join(__dirname, 'dummy-logbook.txt');
    fs.writeFileSync(filePath, 'File dummy logbook Playwright');
    await page.locator('input[name="attachment"]').setInputFiles(filePath);

    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/logbook$/);
    await expect(page.locator('text=Logbook berhasil ditambahkan')).toBeVisible({ timeout: 10000 });

    if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
  });

  test('pegawai bisa edit logbook', async ({ page }) => {
    // Buat logbook baru dulu
    await page.goto('/logbook/create');
    const uniqueDesc = 'Logbook sebelum diedit ' + Date.now();
    await page.fill('textarea[name="description"]', uniqueDesc);
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/logbook$/);

    // Klik Edit di logbook pertama yang statusnya Pending
    const editBtn = page.locator('.item-row').filter({
      hasNot: page.locator('text=Disetujui')
    }).locator('a:has-text("Edit")').first();

    await editBtn.click();
    await page.waitForURL(/.*\/edit/);

    const updatedDesc = 'Logbook setelah diedit ' + Date.now();
    await page.locator('textarea[name="description"]').fill(updatedDesc);
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/logbook$/);
    await expect(page.locator('text=Logbook berhasil diperbarui')).toBeVisible({ timeout: 10000 });
  });

  test('pegawai bisa hapus logbook', async ({ page }) => {
    // Buat logbook baru dulu
    await page.goto('/logbook/create');
    await page.fill('textarea[name="description"]', 'Logbook yang akan dihapus ' + Date.now());
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*\/logbook$/);

    // Hapus logbook pertama yang statusnya Pending
    const hapusBtn = page.locator('.item-row').filter({
      hasNot: page.locator('text=Disetujui')
    }).locator('form button:has-text("Hapus")').first();

    page.on('dialog', dialog => dialog.accept());
    await hapusBtn.click();
    await page.waitForURL(/.*\/logbook$/);
    await expect(page.locator('text=Logbook berhasil dihapus')).toBeVisible({ timeout: 10000 });
  });
});
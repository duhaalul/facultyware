const { test, expect } = require('@playwright/test');

test.describe('Login', () => {
  test.beforeEach(async ({ context }) => {
    await context.clearCookies();
  });

  test('pimpinan berhasil login', async ({ page }) => {
    await page.goto('/login');
    await page.locator('input[name="username"]').fill('Shidiq Maihendra');
    await page.locator('input[name="password"]').fill('pimpinan123');
    await page.locator('button[type="submit"]').click();
    await page.waitForURL(/.*dashboard/, { timeout: 15000 });
    await expect(page.locator('.hero-banner h2')).toContainText('Dashboard Pimpinan');
  });

  test('pegawai berhasil login', async ({ page }) => {
    await page.goto('/login');
    await page.locator('input[name="username"]').fill('Duha Alul Bariq');
    await page.locator('input[name="password"]').fill('pegawai123');
    await page.locator('button[type="submit"]').click();
    await page.waitForURL(/.*dashboard/, { timeout: 15000 });
    await expect(page.locator('.hero-banner h2')).toContainText('Selamat Datang');
  });

  test('login gagal dengan password salah', async ({ page }) => {
    await page.goto('/login');
    await page.locator('input[name="username"]').fill('Shidiq Maihendra');
    await page.locator('input[name="password"]').fill('passwordsalah');

    await page.locator('button[type="submit"]').click();

    // Tunggu sampai redirect kembali ke /login selesai sepenuhnya
    await page.waitForURL(/.*login/, { timeout: 15000 });

    // Tunggu elemen alert muncul, retry otomatis sampai 15 detik
    const alert = page.locator('.alert-danger');
    await expect(alert).toBeVisible({ timeout: 15000 });
    await expect(alert).toContainText('Username atau password salah');
  });

  test('logout berfungsi', async ({ page }) => {
    await page.goto('/login');
    await page.locator('input[name="username"]').fill('Shidiq Maihendra');
    await page.locator('input[name="password"]').fill('pimpinan123');
    await page.locator('button[type="submit"]').click();
    await page.waitForURL(/.*dashboard/, { timeout: 15000 });

    await page.locator('text=Keluar Sistem').click();
    await page.waitForURL(/.*login/, { timeout: 15000 });
  });
});
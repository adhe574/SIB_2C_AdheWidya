<?php 
/**
 * FILE: views/employee_overview.php
 * FUNGSI: Menampilkan ringkasan data keseluruhan karyawan
 */
include 'views/header.php'; 
?>

<h2>📊 Ringkasan Karyawan</h2>

<p style="margin-bottom: 2rem; color: #666;">
    Data berikut diambil dari <code>employee_overview_mv</code> (Materialized View) PostgreSQL.
</p>

<?php if (!empty($overview)): ?>
    <!-- Cards Summary -->
    <div class="dashboard-cards">
        <div class="card">
            <h3>Total Karyawan</h3>
            <div class="number"><?php echo $overview['total_employees']; ?></div>
        </div>
        <div class="card">
            <h3>Total Gaji per Bulan</h3>
            <div class="number">Rp <?php echo number_format($overview['total_salary'], 0, ',', '.'); ?></div>
        </div>
        <div class="card">
            <h3>Rata-rata Masa Kerja</h3>
            <div class="number"><?php echo $overview['avg_years_of_service']; ?> tahun</div>
        </div>
    </div>

    <!-- Tombol Refresh -->
    <div style="text-align:center; margin-top: 30px;">
        <a href="index.php?action=refresh_employee_mv"
           style="
               display: inline-block;
               background-color: #4a6cf7;
               color: #fff;
               padding: 10px 25px;
               border-radius: 8px;
               text-decoration: none;
               font-weight: 500;
               transition: background-color 0.3s ease;
           "
           onmouseover="this.style.backgroundColor='#3651c9'"
           onmouseout="this.style.backgroundColor='#4a6cf7'">
           🔄 Refresh Data
        </a>
    </div>

<?php else: ?>
    <div style="text-align: center; padding: 3rem; background: #f8f9fa; border-radius: 8px;">
        <p style="font-size: 1.2rem; color: #666;">Tidak ada data ringkasan karyawan.</p>
        <p style="color: #999;">Pastikan materialized view <code>employee_overview_mv</code> sudah dibuat dan di-refresh.</p>
    </div>
<?php endif; ?>

<div style="margin-top: 2rem; padding: 1rem; background: #e7f3ff; border-radius: 5px;">
    <strong>Informasi:</strong>
    Data ini dihitung menggunakan fungsi agregat <code>COUNT()</code>, <code>SUM()</code>, dan <code>AVG()</code> untuk menampilkan total karyawan, total gaji, serta rata-rata masa kerja.
</div>

<?php include 'views/footer.php'; ?>

<?php 
/**
 * FILE: views/tenure_stats.php
 * FUNGSI: Menampilkan statistik masa kerja karyawan (Junior, Middle, Senior)
 */
include 'views/header.php'; 
?>

<h2>Statistik Masa Kerja Karyawan</h2>

<p style="margin-bottom: 2rem; color: #666;">
    Data berikut diambil dari <code>tenure_stats_mv</code> (Materialized View) di database PostgreSQL.
</p>

<?php if (!empty($result)): ?>
    <!-- Hitung total -->
    <?php
        $total_employees = array_sum(array_column($result, 'total_employees'));
    ?>

    <!-- Cards Summary -->
    <div class="dashboard-cards">
        <div class="card">
            <h3>Total Karyawan</h3>
            <div class="number"><?php echo $total_employees; ?></div>
        </div>
        <div class="card">
            <h3>Level Masa Kerja</h3>
            <div class="number"><?php echo count($result); ?> Level</div>
        </div>
    </div>

    <!-- Tabel Statistik Detail -->
    <table class="data-table">
        <thead>
            <tr>
                <th>Tingkat Masa Kerja</th>
                <th>Jumlah Karyawan</th>
                <th>Nama Karyawan</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($result as $row): ?>
            <tr>
                <td>
                    <strong><?php echo htmlspecialchars($row['tenure_level']); ?></strong>
                </td>
                <td style="text-align: center;">
                    <span style="padding: 0.25rem 0.75rem; background: #667eea; color: white; border-radius: 20px;">
                        <?php echo $row['total_employees']; ?>
                    </span>
                </td>
                <td>
                    <?php 
                        $names = explode(',', $row['employee_names']);
                        echo "<ul style='margin: 0; padding-left: 20px;'>";
                        foreach ($names as $name) {
                            echo "<li>" . htmlspecialchars(trim($name)) . "</li>";
                        }
                        echo "</ul>";
                    ?>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <!-- Tombol Refresh -->
    <div style="text-align:center; margin-top: 30px;">
        <a href="index.php?action=refresh_tenure_mv" 
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
        <p style="font-size: 1.2rem; color: #666;">Tidak ada data statistik masa kerja.</p>
        <p style="color: #999;">Pastikan materialized view <code>tenure_stats_mv</code> sudah dibuat dan di-refresh.</p>
        <a href="index.php?action=create" class="btn btn-primary" style="margin-top: 1rem;">Tambah Data Karyawan</a>
    </div>
<?php endif; ?>

<div style="margin-top: 2rem; padding: 1rem; background: #e7f3ff; border-radius: 5px;">
    <strong>Informasi:</strong>
    Data ini diambil dari Materialized View PostgreSQL dengan fungsi agregat 
    <code>COUNT()</code> dan <code>STRING_AGG()</code> untuk mengelompokkan karyawan berdasarkan masa kerja.
</div>

<?php include 'views/footer.php'; ?>
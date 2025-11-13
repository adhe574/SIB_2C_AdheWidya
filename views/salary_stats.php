<?php include 'views/header.php'; ?>

<div class="card">
    <h2>📊 Statistik Gaji per Departemen (Materialized View)</h2>

    <p style="color: #555; margin-bottom: 1rem;">
        Berikut data rata-rata, tertinggi, dan terendah gaji tiap departemen. 
        Tekan tombol di bawah untuk memperbarui materialized view.
    </p>

    <!-- Tabel Statistik -->
    <table class="data-table">
        <thead>
            <tr>
                <th>Departemen</th>
                <th>Rata-rata Gaji</th>
                <th>Gaji Tertinggi</th>
                <th>Gaji Terendah</th>
            </tr>
        </thead>
        <tbody>
            <?php if (!empty($result)) : ?>
                <?php foreach ($result as $row): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['department']) ?></td>
                        <td>Rp <?= number_format($row['avg_salary'], 0, ',', '.') ?></td>
                        <td>Rp <?= number_format($row['max_salary'], 0, ',', '.') ?></td>
                        <td>Rp <?= number_format($row['min_salary'], 0, ',', '.') ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="4" style="text-align:center;">Tidak ada data ditemukan.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>

    <!-- Tombol Refresh -->
    <form method="post" action="index.php?action=refresh_salary_mv" style="margin-bottom: 15px;">
        <button type="submit" class="btn-refresh">🔄 Refresh Statistik Gaji</button>
    </form>
</div>

<?php include 'views/footer.php'; ?>
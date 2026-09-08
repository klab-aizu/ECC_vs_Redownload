import numpy as np
import matplotlib.pyplot as plt


# ============================================================
# PARAMETERS
# ============================================================

# Model: 784-100, 32-bit floating point
N_BITS = 2_508_800

# Evaluation period
EXEC_TIME_HOURS = 24.0

# ============================================================
# DRAM ENERGY
# DESTINY, 32-nm CMOS
# ============================================================

E_READ_BIT = 5.607e-12       # J/bit
E_WRITE_BIT = 5.570e-12      # J/bit


# ============================================================
# SD CARD ENERGY
# ============================================================

E_DOWNLOAD_BIT = 3.225e-8   # J/bit


# ============================================================
# DRAM REFRESH
# ============================================================

REFRESH_PERIOD_SEC = 0.064   # 64 ms

F_REFRESH_HZ = 1.0 / REFRESH_PERIOD_SEC
F_REFRESH_HOUR = F_REFRESH_HZ * 3600.0


# ============================================================
# DRAM ROW ORGANIZATION
# ============================================================

# Assumed DRAM row size
# 8 Kbit = 8192 bits
ROW_SIZE_BITS = 8192

# Number of DRAM rows occupied by the model
N_ROWS = int(np.ceil(N_BITS / ROW_SIZE_BITS))


# ============================================================
# ECC OVERHEAD
# ============================================================

# Example:
# 32-bit data + 7-bit ECC = 21.875% overhead
R_OVERHEAD = 1.21875


# ============================================================
# ENERGY CALCULATION FUNCTIONS
# ============================================================

def energy_access(F_access):
    """
    Baseline DRAM access energy.

    F_access:
        memory accesses per hour
    """

    return (
        EXEC_TIME_HOURS
        * F_access
        * N_BITS
        * E_READ_BIT
    )


def energy_refresh():
    """
    DRAM row-based refresh energy.

    The model occupies N_ROWS DRAM rows.
    Each row is refreshed every 64 ms.
    """

    # Energy required to refresh one row
    E_refresh_row = (
        ROW_SIZE_BITS
        * (E_READ_BIT + E_WRITE_BIT)
    )

    # Total refresh energy
    return (
        EXEC_TIME_HOURS
        * F_REFRESH_HOUR
        * N_ROWS
        * E_refresh_row
    )


def energy_redownload(F_download):
    """
    Energy for re-downloading the complete model.

    F_download:
        downloads per hour
    """

    return (
        EXEC_TIME_HOURS
        * F_download
        * N_BITS
        * (E_DOWNLOAD_BIT + E_WRITE_BIT)
    )


def energy_proposed(F_access, F_download):

    return (
        energy_access(F_access)
        + energy_refresh()
        + energy_redownload(F_download)
    )


def energy_ecc(F_access):

    return R_OVERHEAD * (
        energy_access(F_access)
        + energy_refresh()
    )


# ============================================================
# PRINT PARAMETERS
# ============================================================

print("=" * 60)
print("ENERGY ESTIMATION")
print("=" * 60)

print(f"Model size              : {N_BITS:,} bits")
print(f"DRAM row size           : {ROW_SIZE_BITS:,} bits")
print(f"Number of model rows    : {N_ROWS:,}")

print()

print(f"Refresh period          : {REFRESH_PERIOD_SEC*1000:.1f} ms")
print(f"Refresh frequency       : {F_REFRESH_HZ:.3f} Hz")
print(f"Refreshes per hour      : {F_REFRESH_HOUR:,.0f}")

print()

print(f"Read energy             : {E_READ_BIT:.3e} J/bit")
print(f"Write energy            : {E_WRITE_BIT:.3e} J/bit")
print(f"Download energy         : {E_DOWNLOAD_BIT:.3e} J/bit")

print()


# ============================================================
# EXAMPLE
# ============================================================

F_ACCESS = 1.0
F_DOWNLOAD = 1.0 / 24.0

E_access = energy_access(F_ACCESS)
E_refresh = energy_refresh()
E_download = energy_redownload(F_DOWNLOAD)

E_proposed = energy_proposed(
    F_ACCESS,
    F_DOWNLOAD
)

E_ecc = energy_ecc(F_ACCESS)


print("=" * 60)
print("ENERGY BREAKDOWN: ONE DAY")
print("=" * 60)

print(f"Access energy           : {E_access:.6e} J")
print(f"Refresh energy          : {E_refresh:.6e} J")
print(f"Re-download energy      : {E_download:.6e} J")

print()

print(f"Proposed system         : {E_proposed:.6e} J")
print(f"ECC system              : {E_ecc:.6e} J")

print()

print(
    f"Proposed / ECC          : "
    f"{E_proposed / E_ecc:.3f}x"
)

print(
    f"Energy saving           : "
    f"{(1 - E_proposed / E_ecc) * 100:.2f}%"
)


# ============================================================
# PLOT 1
# ENERGY VS ACCESS FREQUENCY
# ============================================================

access_frequencies = np.logspace(-2, 3, 300)

E_proposed_access = np.array([
    energy_proposed(
        F,
        F_DOWNLOAD
    )
    for F in access_frequencies
])

E_ecc_access = np.array([
    energy_ecc(F)
    for F in access_frequencies
])


plt.figure(figsize=(7, 5))

plt.loglog(
    access_frequencies,
    E_proposed_access,
    linewidth=2,
    label="Proposed system"
)

plt.loglog(
    access_frequencies,
    E_ecc_access,
    linewidth=2,
    linestyle="--",
    label="ECC system"
)

plt.xlabel(
    "Memory access frequency (accesses/hour)"
)

plt.ylabel(
    "Energy per day (J)"
)

plt.title(
    "Energy vs. Memory Access Frequency"
)

plt.grid(
    True,
    which="both",
    linestyle=":",
    alpha=0.6
)

plt.legend()

plt.tight_layout()

plt.savefig(
    "energy_vs_access_frequency.pdf",
    dpi=300,
    bbox_inches="tight"
)

plt.show()


# ============================================================
# PLOT 2
# ENERGY VS RE-DOWNLOAD FREQUENCY
# ============================================================

download_frequencies = np.logspace(-3, 1, 300)

E_proposed_download = np.array([
    energy_proposed(
        F_ACCESS,
        F
    )
    for F in download_frequencies
])

E_ecc_constant = energy_ecc(F_ACCESS)


plt.figure(figsize=(7, 5))

plt.loglog(
    download_frequencies,
    E_proposed_download,
    linewidth=2,
    label="Proposed system"
)

plt.axhline(
    E_ecc_constant,
    linewidth=2,
    linestyle="--",
    label="ECC system"
)

plt.xlabel(
    "Re-download frequency (downloads/hour)"
)

plt.ylabel(
    "Energy per day (J)"
)

plt.title(
    "Energy vs. Re-download Frequency"
)

plt.grid(
    True,
    which="both",
    linestyle=":",
    alpha=0.6
)

plt.legend()

plt.tight_layout()

plt.savefig(
    "energy_vs_download_frequency.pdf",
    dpi=300,
    bbox_inches="tight"
)

plt.show()


# ============================================================
# PLOT 3
# PROPOSED / ECC ENERGY RATIO
# ============================================================

access_grid = np.logspace(-2, 3, 150)
download_grid = np.logspace(-3, 1, 150)

A, D = np.meshgrid(
    access_grid,
    download_grid
)

E_proposed_grid = (
    EXEC_TIME_HOURS
    * A
    * N_BITS
    * E_READ_BIT
    +
    EXEC_TIME_HOURS
    * F_REFRESH_HOUR
    * N_ROWS
    * ROW_SIZE_BITS
    * (E_READ_BIT + E_WRITE_BIT)
    +
    EXEC_TIME_HOURS
    * D
    * N_BITS
    * (E_DOWNLOAD_BIT + E_WRITE_BIT)
)

E_ecc_grid = (
    R_OVERHEAD
    *
    (
        EXEC_TIME_HOURS
        * A
        * N_BITS
        * E_READ_BIT
        +
        EXEC_TIME_HOURS
        * F_REFRESH_HOUR
        * N_ROWS
        * ROW_SIZE_BITS
        * (E_READ_BIT + E_WRITE_BIT)
    )
)

energy_ratio = E_proposed_grid / E_ecc_grid


plt.figure(figsize=(7, 5))

contour = plt.contourf(
    A,
    D,
    energy_ratio,
    levels=30
)

plt.xscale("log")
plt.yscale("log")

plt.xlabel(
    "Memory access frequency (accesses/hour)"
)

plt.ylabel(
    "Re-download frequency (downloads/hour)"
)

plt.title(
    "Proposed / ECC Energy Ratio"
)

cbar = plt.colorbar(contour)

cbar.set_label(
    "Proposed / ECC energy ratio"
)

plt.tight_layout()

plt.savefig(
    "energy_ratio_heatmap.pdf",
    dpi=300,
    bbox_inches="tight"
)

plt.show()


# ============================================================
# BREAK-EVEN DOWNLOAD FREQUENCY
# ============================================================

E_base = (
    energy_access(F_ACCESS)
    + energy_refresh()
)

F_break_even = (
    (R_OVERHEAD - 1.0)
    * E_base
    /
    (
        EXEC_TIME_HOURS
        * N_BITS
        * (E_DOWNLOAD_BIT + E_WRITE_BIT)
    )
)

print()
print("=" * 60)
print("BREAK-EVEN ANALYSIS")
print("=" * 60)

print(
    f"Break-even download frequency = "
    f"{F_break_even:.6e} downloads/hour"
)

print(
    f"Break-even interval            = "
    f"{1/F_break_even:.2f} hours/download"
)

print(
    f"Break-even downloads/day       = "
    f"{24*F_break_even:.4f}"
)
You have 150GB of unpartitioned space on your disk (`/dev/sda`). To resize `ubuntu--vg-ubuntu--lv` and make use of this space, follow these steps:

### **Step 1: Create a New Partition**
1. Open a terminal and start `fdisk`:
   ```bash
   sudo fdisk /dev/sda
   ```
2. Create a new primary partition:
   - Press `n` (new partition)
   - Select `p` (primary)
   - Choose the default partition number
   - Press `Enter` to accept the default start sector
   - Press `Enter` to accept the default end sector (using all available space)
3. Change partition type to LVM:
   - Press `t` (change partition type)
   - Select the new partition number
   - Type `8e` (Linux LVM)
4. Write the changes and exit:
   - Press `w` (write changes and exit)

### **Step 2: Update Kernel to Recognize the New Partition**
Run:
```bash
sudo partprobe
```
If partprobe is not available, reboot the system.

### **Step 3: Convert the New Partition to a Physical Volume**
```bash
sudo pvcreate /dev/sda4
```
(Assuming the new partition is `/dev/sda4`, adjust if needed.)

### **Step 4: Extend the Volume Group**
```bash
sudo vgextend ubuntu-vg /dev/sda4
```

### **Step 5: Extend the Logical Volume**
```bash
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
```

### **Step 6: Resize the Filesystem**
For **EXT4** filesystem:
```bash
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
```
For **XFS** filesystem:
```bash
sudo xfs_growfs /
```

### **Step 7: Verify the Changes**
```bash
df -h
```

Now, your logical volume should have the additional 150GB available. Let me know if you need any modifications! 🚀

No, you **do not** need to modify `/etc/fstab` or run `mount -a` for these changes to persist across reboots. Here’s why:

### **Why?**
1. **LVM Changes Persist Automatically**  
   - The new partition (`/dev/sda4` → LVM) is added to the volume group (`ubuntu-vg`).
   - Logical volume (`ubuntu--vg-ubuntu--lv`) is resized.
   - These changes are stored in the LVM metadata and persist across reboots.

2. **Filesystem Resizing is Permanent**  
   - The `resize2fs` (for EXT4) or `xfs_growfs` (for XFS) command permanently resizes the filesystem.

### **Verification After Reboot**
After a reboot, verify the changes using:
```bash
df -h   # Check available space
lsblk    # Confirm the volume sizes
sudo vgs # Check volume group size
sudo lvs # Check logical volume size
```

### **When to Modify `/etc/fstab`?**
You only need to modify `/etc/fstab` if:
1. You created a new partition **outside LVM** (not applicable here).
2. You want to mount an additional partition separately.
3. You need to change mount options (e.g., adding `noatime`, `discard` for SSDs).

Since you're expanding an **existing** LVM volume, there's **no need** to update `/etc/fstab`. 🚀

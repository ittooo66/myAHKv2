# Need https://github.com/frgnca/AudioDeviceCmdlets

Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Select Audio Device"
$form.Size = New-Object System.Drawing.Size(350,250)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Create the list box
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,10)
$listBox.Size = New-Object System.Drawing.Size(320,150)

# Create a panel for buttons
$buttonPanel = New-Object System.Windows.Forms.Panel
$buttonPanel.Location = New-Object System.Drawing.Point(10,170)
$buttonPanel.Size = New-Object System.Drawing.Size(320,40)

# Create the OK button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "OK"
$okButton.Size = New-Object System.Drawing.Size(90,30)
$okButton.Location = New-Object System.Drawing.Point(110,5)
$okButton.Add_Click({ $form.DialogResult = [System.Windows.Forms.DialogResult]::OK })

# Create the Cancel button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Text = "Cancel"
$cancelButton.Size = New-Object System.Drawing.Size(90,30)
$cancelButton.Location = New-Object System.Drawing.Point(210,5)
$cancelButton.Add_Click({ $form.Close() })

# Get the list of audio devices
$audioDevices = Get-AudioDevice -List | Where-Object { $_.Type -eq "Playback" }
$audioDevices | ForEach-Object { $listBox.Items.Add($_.Name) }

# Add controls to the panel
$buttonPanel.Controls.Add($okButton)
$buttonPanel.Controls.Add($cancelButton)

# Add controls to the form
$form.Controls.Add($listBox)
$form.Controls.Add($buttonPanel)

# Show the form and process the selected result
if ($form.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK -and $listBox.SelectedIndex -ge 0) {
    $selectedDevice = $audioDevices[$listBox.SelectedIndex]
    Set-AudioDevice -Index $selectedDevice.Index
}

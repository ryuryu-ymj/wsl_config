function wclip2image
    powershell.exe -Command "(Get-Clipboard -Format Image).Save(\"$argv[1]\")"
end

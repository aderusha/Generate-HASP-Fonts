####################################################################################################
#
# Generate-HASP-Fonts.ps1
# 
# Create the Nextion ZI version 5 fonts used by the HASP project
#
# All the real hard work done by https://github.com/fvanroie.  THANK YOU FVANROIE!
#
# ZiLib library included here sourced from:
# https://github.com/fvanroie/nextion-font-editor
#
# Noto Sans font included here sourced from:
# https://github.com/googlefonts/noto-fonts/tree/master/hinted/NotoSans
# License: https://github.com/googlefonts/noto-fonts/blob/master/LICENSE
#
# MaterialDesign font included here sourced from:
# https://github.com/Templarian/MaterialDesign-Font
#
####################################################################################################
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this hardware,
# software, and associated documentation files (the "Product"), to deal in the Product without
# restriction, including without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Product, and to permit persons to whom the
# Product is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Product.
#
# THE PRODUCT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
# NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE PRODUCT OR THE USE OR OTHER DEALINGS IN THE PRODUCT.

Set-Location $PSScriptRoot
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
Add-Type -Path ./ZiLib.dll

Function Main {
  $codePage = [ZiLib.CodePageIdentifier]::utf_8

  $outfile = "output" | Resolve-Path | ForEach-Object { $_.Path }
  $textFont = "./NotoSans-Regular.ttf" | Get-ChildItem | ForEach-Object { $_.FullName }
  $iconFont = "./MaterialDesignIconsDesktop.ttf" | Get-ChildItem | ForEach-Object { $_.FullName }

  $fontSize = 24
  $textVerticalOffset = 0
  $iconVerticalOffset = 4
  New-ZiFontV5 -textFont $textFont -iconFont $iconFont -iconFontFirstCP 0xf0001 -iconFontLastCP 0xf13fe -iconCPOffset 0xE2001 -iconVerticalOffset $iconVerticalOffset -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $fontSize = 32
  $textVerticalOffset = 0
  $iconVerticalOffset = 4
  New-ZiFontV5 -textFont $textFont -iconFont $iconFont -iconFontFirstCP 0xf0001 -iconFontLastCP 0xf13fe -iconCPOffset 0xE2001 -iconVerticalOffset $iconVerticalOffset -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $fontSize = 48
  $textVerticalOffset = 0
  $iconVerticalOffset = 8
  New-ZiFontV5 -textFont $textFont -iconFont $iconFont -iconFontFirstCP 0xf0001 -iconFontLastCP 0xf13fe -iconCPOffset 0xE2001 -iconVerticalOffset $iconVerticalOffset -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $fontSize = 64
  $textVerticalOffset = 0
  $iconVerticalOffset = 8
  New-ZiFontV5 -textFont $textFont -iconFont $iconFont -iconFontFirstCP 0xf0001 -iconFontLastCP 0xf13fe -iconCPOffset 0xE2001 -iconVerticalOffset $iconVerticalOffset -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $fontSize = 80
  $textVerticalOffset = -12
  $iconVerticalOffset = 4
  New-ZiFontV5 -textFont $textFont -iconFont $iconFont -iconFontFirstCP 0xf0001 -iconFontLastCP 0xf13fe -iconCPOffset 0xE2001 -iconVerticalOffset $iconVerticalOffset -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $textFont = "./NotoSans-Bold.ttf" | Get-ChildItem | ForEach-Object { $_.FullName }
  $fontSize = 80
  $textVerticalOffset = -12
  $iconVerticalOffset = 4
  New-ZiFontV5 -textFont $textFont -iconFont $iconFont -iconFontFirstCP 0xf0001 -iconFontLastCP 0xf13fe -iconCPOffset 0xE2001 -iconVerticalOffset $iconVerticalOffset -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $textFont = "$($Env:windir)\Fonts\Consola.ttf"
  $fontSize = 24
  $textVerticalOffset = 0
  New-ZiFontV5 -textFont $textFont -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $fontSize = 32
  New-ZiFontV5 -textFont $textFont -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $fontSize = 48
  New-ZiFontV5 -textFont $textFont -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $textFont = "$($Env:windir)\Fonts\Consolab.ttf"
  $fontSize = 80
  $textVerticalOffset = -12
  New-ZiFontV5 -textFont $textFont -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile

  $textFont = "$($Env:windir)\Fonts\Webdings.ttf"
  $fontSize = 56
  $textVerticalOffset = 0
  New-ZiFontV5 -textFont $textFont -textVerticalOffset $textVerticalOffset -size $fontSize -Codepage $codePage -Path $outfile
}

Function New-ZiFontV5 {
  [CmdletBinding()]
  param (
    [Parameter(Position = 0, Mandatory = $true, HelpMessage = "Text font filename")][ValidateScript( { Test-Path $_ })][string]$textFont,
    [Parameter(Position = 1, Mandatory = $false, HelpMessage = "Icon font filename")][ValidateScript( { Test-Path $_ })][string]$iconFont,
    [Parameter(Position = 2, Mandatory = $false, HelpMessage = "Icon font start codepoint")][int]$iconFontFirstCP,
    [Parameter(Position = 3, Mandatory = $false, HelpMessage = "Icon font end codepoint")][int]$iconFontLastCP,
    [Parameter(Position = 4, Mandatory = $false, HelpMessage = "Icon font codepoint offset to fit result below 0xFFFF")][int]$iconCPOffset,
    [Parameter(Position = 5, Mandatory = $false, HelpMessage = "Icon font vertical offset")][int]$iconVerticalOffset = 0,
    [Parameter(Position = 6, Mandatory = $false, HelpMessage = "Text font vertical offset")][int]$textVerticalOffset = 0,
    [Parameter(Position = 7, Mandatory = $true, HelpMessage = "Generated font size")][byte[]]$size,
    [Parameter(Position = 8, Mandatory = $false, HelpMessage = "Font codepage")]$Codepage = [ZiLib.CodePageIdentifier]::utf_8,
    [Parameter(Position = 9, Mandatory = $true, HelpMessage = "Generated font output folder")][string]$Path
  )

  $iconSet = @()
  for ($i = $iconFontFirstCP; $i -le $iconFontLastCP; $i++) {
    $iconSet += $i
  }
  $locationText = [System.Drawing.PointF]::new(0, $textVerticalOffset)
  $locationIcon = [System.Drawing.PointF]::new(0, $iconVerticalOffset)

  foreach ($fontsize in $size) {

    $file = Get-ChildItem $textFont
    $newfontsize = $fontsize

    # Check if fontname is a otf/ttf file
    if ((($file.Extension -eq ".ttf") -or ($file.Extension -eq ".otf")) -and ($file.Exists)) {
      $pfc = [System.Drawing.Text.PrivateFontCollection]::new()
      $pfc.AddFontFile($textFont)
      $font = [System.Drawing.Font]::new($pfc.Families[0], $newfontsize, "regular", [System.Drawing.GraphicsUnit]::pixel );
      
      if ($iconFont) {
        $pfc.AddFontFile($iconFont)
        $iconFontSet = $pfc.families | Select-Object -First 1
      }
    }
    else {
      $font = [ZiLib.Extensions.BitmapExtensions]::GetFont($textFont, $newfontsize, "Regular")
    }

    $i = 0
    while ([math]::Abs($fontsize - $font.Height) -gt 0.1 -and $i++ -lt 10) {
      $newfontsize += ($fontsize - $font.Height) / 2 * $newfontsize / $font.Height;
      $font = [System.Drawing.Font]::new($font.fontfamily, $newfontsize, "regular", [System.Drawing.GraphicsUnit]::pixel );
    }

    $f = [ZiLib.FileVersion.V5.ZiFontV5]::new()
    $f.CharacterHeight = $fontsize
    $f.CodePage = $codepage
    $f.Version = 5

    # Letters
    foreach ($ch in 32..255) {
      # normal text
      $bytes = [bitconverter]::GetBytes([uint16]$ch)
      if ($f.CodePage.CodePageIdentifier -eq "UTF_8") {
        if ($ch -lt 0x00d800 -or $ch -gt 0x00dfff) {
          $txt = [Char]::ConvertFromUtf32([uint32]($ch + $codepoint.delta))
        }
        else { $txt = "?" }
      }
      else {
        if ($ch -gt 255) {
          $txt = $f.CodePage.Encoding.GetChars($bytes, 0, 2)
        }
        else {
          $txt = $f.CodePage.Encoding.GetChars($bytes, 0, 1)
        }
      }

      $character = [ZiLib.FileVersion.Common.ZiCharacter]::FromString($f, $ch, $font, $locationText, $txt)
      $f.AddCharacter($ch, $character)
    }

    if ($iconFont) {
      $font = [System.Drawing.Font]::new($iconFontSet, $newfontsize, "regular", [System.Drawing.GraphicsUnit]::pixel )
      foreach ($ch in $iconFontFirstCP..$iconFontLastCP) {
        $txt = [Char]::ConvertFromUtf32([uint32]($ch))
        $character = [ZiLib.FileVersion.Common.ZiCharacter]::FromString($f, $ch - $iconCPOffset, $font, $locationIcon, $txt)
        $f.AddCharacter($ch, $character)
      }
    }

    $file = Get-Item $textFont
    $filename = $file.basename
    $f.Name = $filename

    New-Item -ItemType Directory -Path $path -Force | Out-Null
    $outfile = Join-Path -Path $path -ChildPath ("{0} {1} ({2}).zi" -f $filename, $fontsize, $Codepage)
    Write-Host "Writing $outfile"
    $f.Save($outfile)
  }
}

Main
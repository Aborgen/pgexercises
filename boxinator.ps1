# Script for encasing data copied from an HTML <table> element in an ascii table.
# Outputs to console as well as puts it in your clipboard.
<#
Example:
+------------+-------------+------+
| Field      | Type        | Null |
+------------+-------------+------+
| id         | int(11)     | NO   | 
| Name       | varchar(50) | YES  |
| Contact_id | int(11)     | YES  |
+------------+-------------+------+
#>

# Will return a string of meaningful '-' and '+' symbols of length $borderLength.
# The $borderIndicators Queue lets us know where the '+' symbols go.
function printBorder($borderLength, $borderIndicators) {
  $border = '';
  for ($i = 0; $i -lt $borderLength - 1; $i++) {
    if (
      ($borderIndicators.Count -gt 0) -and 
      ($i -eq $borderIndicators[0])
    ) {
      $border += '+';
      $borderIndicators.RemoveAt(0) | Out-Null;
    }
    else {
      $border += '-';
    }
  }

  return $border;
}

# Will return the length of the longest row
function getBorderLength($rows) {
  $borderLength = 0;
  foreach ($row in $rows) {
    # Each row will always have a symbol at the beginning and the end. Minimum length of 2.
    $rowLength = 2;
    foreach ($word in $row) {
      # A word is surrounded by spaces on both sides, as well as one extra symbol to the right.
      $rowLength += ($word.Length + 3);
    }
    
    if ($rowLength -gt $borderLength) {
      $borderLength = $rowLength;
    }
  }
  
  return $borderLength;
}

# Splits large strings by newline and then by tab character.
# This is text copied from an HTML <table>.
function splitIntoRows($content) {
  $splitContent = $content.Split("`n");
  $rows = [System.Collections.ArrayList]::new();
  for ($i = 0; $i -lt $splitContent.Count; $i++) {
    $row = $splitContent[$i].Split("`t");
    foreach ($word in $row) {
      $word = $word.Trim();
    }

    $rows.Add($row) | Out-Null;
  }
  
  squarePadding($rows);
  return $rows;
}

# Define where we will be placing '+' on the borders.
$borderIndicators = [System.Collections.ArrayList]::new();
$borderIndicators.Add(0) | Out-Null;
function squarePadding($rows) {
  $numberOfColumns = $rows[0].Count;
  for ($i = 0; $i -lt $numberOfColumns; $i++) {
    $longestLength = 0;
    foreach ($row in $rows) {
      $word = $row[$i];
      # We want the longest word per row
      if ($word.Length -gt $longestLength) {
        $longestLength = $word.Length;
      }
    }
    
    # Pad each word with whitespace to ensure they are all the same length
    foreach ($row in $rows) {
      $diff = $longestLength - $row[$i].Length;
      for ($j = 0; $j -lt $diff; $j++) {
        $row[$i] += ' ';
      }
    }
    
    $previousIndicator = $borderIndicators[$borderIndicators.Count - 1];
    # We must add 2, because each value will be surrounded by two additional spaces.
    # We add 1, because we want the symbol to appear one space over.
    $nextIndicator = ($longestLength + 3) + $previousIndicator;
    $borderIndicators.Add($nextIndicator) | Out-Null;
  }
}

function constructBox($rows, $border) {
  $box = "$border`n";
  for ($i = 0; $i -lt $rows.Count; $i++) {
    $row = $rows[$i];
    for ($j = 0; $j -lt $row.Count; $j++) {
      $word = $row[$j];
      # Beginning of row
      if ($j -eq 0) {
        $box += '|';
      }

      $box += " $word |";
    }
    
    # Next row
    $box += "`n";
    
    # A border to separate the category rows from the content
    if ($i -eq 0) {
      $box += "$border`n";
    }
  }
  
  $box += $border;
  return $box;
}

$rows = splitIntoRows(Get-Clipboard);
$borderLength = getBorderLength($rows);
$border = printBorder $borderLength $borderIndicators;
$box = constructBox $rows $border;

Write-Host $box;

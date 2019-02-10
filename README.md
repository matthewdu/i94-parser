# i94-parser
---

This is a simple parser for figuring out how many days you have stayed in the US per year. It takes data from the I94 history page. I wrote it mainly to help fill out Schedule OI - Other Information for the 1040NR tax form.

## Quick Start
Clone and be in root directory project:
```
ruby parser.rb demo.txt
```

## Usage
This requires that ruby is installed.

```
./parser.rb file_path [--debug]
OR
ruby parser.rb file_path [--debug]
```

file_path is input to data from the I94 history page. The section below explains the file format.

### Input file format
The input file is a reverse chronological list of arrival and departure dates. The file should be formatted as such:

```
1
2018-11-28
Arrival
SFR
2
2018-10-10
Departure
SFR
...
```

If you copy can paste the table from the I94 history section it should just work. Make sure there is no newline at the end of the file.

### --debug option

This will show arrival and departure pairings; as well as duration of each stay. If you use this, you might notice that there are `Fake` travel dates inserted. This is for cases where your arrival and departure dates are in different years.

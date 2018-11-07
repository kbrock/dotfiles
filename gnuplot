# Default colors for gnuplot
#
# Configured to use simlar styles from grafana

set macros

FONT         = 'font "Helvetica"'
BKGRND       = 'background rgb "#1f1d1d"'

USE_PNG_TERM    = "set terminal png size 1024.768 ".FONT.BKGRND
USE_SVG_TERM    = "set terminal svg size 1024,768 dynamic ".FONT.BKGRND
USE_CANVAS_TERM = "set terminal canvas size 1024.768 standalone ".FONT.BKGRND


# Titles
set title textcolor rgb "#D8D9DA"

# Tic and label styles
set xlabel textcolor rgb "#D8D9DA"
set xtic textcolor rgb "#D8D9DA"
set x2label textcolor rgb "#D8D9DA"
set x2tic textcolor rgb "#D8D9DA"
set ylabel textcolor rgb "#D8D9DA"
set ytic textcolor rgb "#D8D9DA"
set y2label textcolor rgb "#D8D9DA"
set y2tic textcolor rgb "#D8D9DA"

# Legend (Key) Styles
set key left bottom outside horizontal nobox textcolor rgb "#D8D9DA"

# Border styles
set style line 80 linetype 1 linecolor rgb "#545454"
set border 11 back linestyle 80

# Grid styles
set style line 81 linetype 1 linecolor rgb "#545454" linewidth 0.5
set grid xtics
set grid ytics
set grid back ls 81

# Use lines type by default
set style data lines

# Default lines styles
set linetype 1 linecolor rgb "#6ED0E0" linewidth 1 # blue    dk: #386B73
set linetype 2 linecolor rgb "#7EB26D" linewidth 1 # green   dk: #517346
set linetype 3 linecolor rgb "#EAB839" linewidth 1 # yellow  dk: #735A1C
set linetype 4 linecolor rgb "#E24D42" linewidth 1 # red     dk: #732722
set linetype 5 linecolor rgb "#D57733" linewidth 1 # orange  dk: #73401B
# set linetype 6 linecolor rgb "#202D3A" linewidth 1 # dk blue


str="abclkbsldcasboiboicoiudpoiudcd" 
query="abcd"
| first a: 26 | second a: 8 | tot: 34
abc.....d|abc...................d|abc.......................d|abc........................d| (4)
ab.......c............d|ab.......c.................d|ab.......c..................d| (3)
ab................c...d|ab................c........d|ab................c..........d| (3)
ab..........................cd (1)
a....b...c............d|a....b...c.................d|a....b...c...................d (3)
a....b............c...d|a....b............c........d|a....b............c..........d (3)
a....b......................cd (1)
a...........b.....c...d|a...........b.....c........d|a...........b.....c..........d (3)
a...........b...............cd (1)
a..............b..c...d|a..............b..c........d|a..............b..c..........d (3)
a..............b............cd (1)

sub_str='asboiboic oiudpoiudcd'
a.b.....c...d|a.b.....c........d|a.b.....c..........d (3)
a.b...............cd (1)
a....b..c...d|a....b..c........d|a....b..c..........d (3)
a....b............cd (1)
from riak.client import RiakClient
from riak.riak_error import RiakError
import sys
import time
from datetime import datetime
import calendar
import csv

client = RiakClient(host=sys.argv[1], pb_port=8087)
table_name = sys.argv[2]

# Create table
print "Creating table..."
print "Schema: CREATE TABLE " + table_name + " (status varchar not null, extid varchar not null, ts timestamp not null, avgMeasuredTime sint64 not null, avgSpeed sint64 not null, medianMeasuredTime sint64 not null, vehicleCount sint64 not null, PRIMARY KEY ((status, extid, quantum(ts, 30, 'd')), status, extid, ts))"

time1 = int(round(time.time() * 1000))
try:
    print "Create table return: ", str(client.ts_query(table_name, "CREATE TABLE {table} (status varchar not null, extid varchar not null, ts timestamp not null, avgMeasuredTime sint64 not null, avgSpeed sint64 not null, medianMeasuredTime sint64 not null, vehicleCount sint64 not null, PRIMARY KEY ((status, extid, quantum(ts, 30, 'd')), status, extid, ts))"))
except RiakError as e:
    print "Table " + table_name + " already exists."
time2 = int(round(time.time() * 1000))
print "Time elapsed (ms): ", str(time2 - time1)
print "\n"

table = client.table(table_name)

def changetime(stime):
    dt=datetime.strptime(stime,'%Y-%m-%dT%H:%M:%S')
    #print dt
    return calendar.timegm(datetime.timetuple(dt))*1000

totalcount=0
batchcount=0
batchsize=5000
ds=[]
with open('data.csv', 'rU') as infile:
    r=csv.reader(infile)
    for l in r:
        if l[0]!='status':
            newl=[l[0],str(l[3]),datetime.strptime(l[5],'%Y-%m-%dT%H:%M:%S'),int(l[1]),int(l[2]),int(l[4]),int(l[6])]
            totalcount=totalcount+1
            #print count
            ds.append(newl)
            batchcount=batchcount+1
            if batchcount==batchsize:
                #add the records to the table
                print "Count at  ", totalcount
                to=table.new(ds)
                print "Created ts object"
                print "Storage result:  ",to.store()
                batchcount=0
                ds=[]       

infile.close()
print "Input file closed"

to=table.new(ds)
print "Storage result:  ",to.store()
print totalcount

from riak.client import RiakClient
from riak.riak_error import RiakError
import sys
import time

client = RiakClient(host=sys.argv[1], pb_port=8087)
table_name = sys.argv[2]
table = client.table(table_name)

query = "SELECT COUNT(*) FROM {table} where ts > 1392249600000 and ts < 1397347199000 and status='OK' and extid='668'"
print "Query: ", query
time1 = int(round(time.time() * 1000))
ts_obj = client.ts_query(table_name, query)
time2 = int(round(time.time() * 1000))
print ts_obj.rows
print "Time elapsed (ms): ", str(time2 - time1)
print "\n"

query = "SELECT * FROM {table} where ts > 1392249600000 and ts < 1397347199000 and status='OK' and extid='668'"
print "Query: ", query
time1 = int(round(time.time() * 1000))
ts_obj = client.ts_query(table_name, query)
time2 = int(round(time.time() * 1000))
print ts_obj.rows
print "Time elapsed (ms): ", str(time2 - time1)
print "\n"

query = "SELECT MAX(avgSpeed) FROM {table} where ts > 1392249600000 and ts < 1397347199000 and status='OK' and extid='668'"
print "Query: ", query
time1 = int(round(time.time() * 1000))
ts_obj = client.ts_query(table_name, query)
time2 = int(round(time.time() * 1000))
print ts_obj.rows
print "Time elapsed (ms): ", str(time2 - time1)
print "\n"

query = "SELECT min(avgSpeed) FROM {table} where ts > 1392249600000 and ts < 1397347199000 and status='OK' and extid='668'"
print "Query: ", query
time1 = int(round(time.time() * 1000))
ts_obj = client.ts_query(table_name, query)
time2 = int(round(time.time() * 1000))
print ts_obj.rows
print "Time elapsed (ms): ", str(time2 - time1)
print "\n"

query = "SELECT max(vehicleCount) FROM {table} where ts > 1392249600000 and ts < 1397347199000 and status='OK' and extid='668'"
print "Query: ", query
time1 = int(round(time.time() * 1000))
ts_obj = client.ts_query(table_name, query)
time2 = int(round(time.time() * 1000))
print ts_obj.rows
print "Time elapsed (ms): ", str(time2 - time1)
print "\n"


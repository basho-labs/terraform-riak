import datetime
from riak.client import RiakClient
import sys

client = RiakClient(host=sys.argv[1], pb_port=8087)

fmt = """
select time, weather, temperature from {table} where
    myfamily = '{family}' and
    myseries = '{series}' and
    time >= {t1} and time <= {t2}
"""
query = fmt.format(table=sys.argv[2], family='family1', series='series1', t1=1420113600000, t2=1420113900000)
print query
ts_obj = client.ts_query(sys.argv[2], query)
print "Query result rows:"
print ts_obj.rows

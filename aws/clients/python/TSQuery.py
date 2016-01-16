import datetime
from riak.client import RiakClient
import sys
from riak.riak_error import RiakError

client = RiakClient(host=sys.argv[1], pb_port=8087)

print "## select all columns"
fmt = """
select * from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## select one column"
fmt = """
select weather from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## select multiple columns"
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## use integer for a column that is defined as double (will fail)"
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25
"""
query = fmt.format(table=sys.argv[2])
print query
try:
    ts_obj = client.ts_query(sys.argv[2], query)
except RiakError as e:
    print "ERROR: " + e.value
else:
    print ts_obj.rows
print "\n"

print "## use >"
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## use >="
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature >= 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## use <"
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature < 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## use <="
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature <= 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## use ="
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature = 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## use !="
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature != 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## use parenthesis"
fmt = """
select time, weather, temperature from {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and (temperature > 25.0 OR weather = 'hot')
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## count"
fmt = """
select count(*) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## count with filter"
fmt = """
select count(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## avg"
fmt = """
select avg(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## avg with filter"
fmt = """
select avg(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## max"
fmt = """
select max(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## max with filter"
fmt = """
select max(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## min"
fmt = """
select min(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## min with filter"
fmt = """
select min(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## stddev"
fmt = """
select stddev(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## stddev with filter"
fmt = """
select stddev(temperature) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## arithmetic-numerics"
fmt = """
SELECT 555, 1.1, 1e1, 1.123e-2 from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
ts_obj = client.ts_query(sys.argv[2], query)
print ts_obj.rows
print "\n"

print "## arithmetic-operations"
fmt = """
SELECT temperature, temperature + 5, temperature - 5, temperature * 2, temperature / 2, -temperature, (temperature + 5)/2, (temperature * 10)/(2 - 100) from  {table} where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000
"""
query = fmt.format(table=sys.argv[2])
print query
try:
    ts_obj = client.ts_query(sys.argv[2], query)
except RiakError as e:
    print "ERROR: " + e.value
else:
    print ts_obj.rows
print "\n"

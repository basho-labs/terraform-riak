import java.net.UnknownHostException;
import java.util.concurrent.ExecutionException;
import com.basho.riak.client.api.RiakClient;
import com.basho.riak.client.api.commands.timeseries.Query;
import com.basho.riak.client.core.query.timeseries.*;
import java.util.*;

public class TSQuery {
    public static void main(String [] args) throws UnknownHostException, ExecutionException, InterruptedException {

        RiakClient client = RiakClient.newClient(8087, args[0]);


System.out.println("## select all columns");
String queryText = "select * from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
Query query = new Query.Builder(queryText).build();
QueryResult queryResult = client.execute(query);
List<Row> rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %7s, %7s, %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getVarcharAsUTF8String(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getTimestamp(), row.getCellsCopy().get(3).getVarcharAsUTF8String(), row.getCellsCopy().get(4).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## select one column");
queryText = "select weather from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %7s %n", row.getCellsCopy().get(0).getVarcharAsUTF8String());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## select multiple columns");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## Use integer for a column that is defined as double (will fail)");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
boolean success = true;
try {
    queryResult = client.execute(query);
} catch (Exception e) {
    System.err.println("ERROR: " + e.getMessage());
    System.out.println();
    success = false;
}
if (success) {
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();
}

System.out.println("## use >");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## use >=");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature >= 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## use <");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature < 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## use <=");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature <= 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## use =");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature = 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## use !=");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature != 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## do not use series in the query (will fail)");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
success = true;
try {
    queryResult = client.execute(query);
} catch (Exception e) {
    System.err.println("ERROR: " + e.getMessage());
    System.out.println();
    success = false;
}
if (success) {
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();
}

System.out.println("## use unbounded time (will fail)");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and temperature > 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
success = true;
try {
    queryResult = client.execute(query);
} catch (Exception e) {
    System.err.println("ERROR: " + e.getMessage());
    System.out.println();
    success = false;
}
if (success) {
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();
}

System.out.println("## do not use parenthesis (will fail)");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0 OR weather = 'hot'";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
success = true;
try {
    queryResult = client.execute(query);
} catch (Exception e) {
    System.err.println("ERROR: " + e.getMessage());
    System.out.println();
    success = false;
}
if (success) {
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();
}

System.out.println("## use parenthesis");
queryText = "select time, weather, temperature from " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and (temperature > 25.0 OR weather = 'hot')";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %10d, %7s, %3.1f %n", row.getCellsCopy().get(0).getTimestamp(), row.getCellsCopy().get(1).getVarcharAsUTF8String(), row.getCellsCopy().get(2).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## count");
queryText = "select count(*) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %d %n", row.getCellsCopy().get(0).getLong());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## count with filter");
queryText = "select count(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %d %n", row.getCellsCopy().get(0).getLong());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## avg");
queryText = "select avg(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## avg with filter");
queryText = "select avg(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## max");
queryText = "select max(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## max with filter");
queryText = "select max(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## min");
queryText = "select min(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## min with filter");
queryText = "select min(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## stddev");
queryText = "select stddev(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## stddev with filter");
queryText = "select stddev(temperature) from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000 and temperature > 25.0";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## arithmetic - numerics");
queryText = "select 555, 1.1, 1e1, 1.123e-2 from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %d, %3.1f, %3.1f, %3.1f %n", row.getCellsCopy().get(0).getLong(), row.getCellsCopy().get(1).getDouble(), row.getCellsCopy().get(2).getDouble(), row.getCellsCopy().get(3).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## arithmetic - operations");
queryText = "select temperature, temperature + 5, temperature - 5, temperature * 2, temperature / 2, -temperature, (temperature + 5)/2, temperature * 10/2 - 100 from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
queryResult = client.execute(query);
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f, %3.1f, %3.1f, %3.1f, %3.1f, %3.1f, %3.1f, %3.1f %n", row.getCellsCopy().get(0).getDouble(), row.getCellsCopy().get(1).getDouble(), row.getCellsCopy().get(2).getDouble(), row.getCellsCopy().get(3).getDouble(), row.getCellsCopy().get(4).getDouble(), row.getCellsCopy().get(5).getDouble(), row.getCellsCopy().get(6).getDouble(), row.getCellsCopy().get(7).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();

System.out.println("## arithmetic (will fail)");
queryText = "select temperature + weather from  " + args[1] + " where myfamily = 'family1' and myseries = 'series1' and time >= 1420113600000 and time <= 1420119300000";
System.out.println(queryText);
query = new Query.Builder(queryText).build();
success = true;
try {
    queryResult = client.execute(query);
} catch (Exception e) {
    System.err.println("ERROR: " + e.getMessage());
    System.out.println();
    success = false;
}
if (success) {
rows = queryResult.getRowsCopy();
System.out.println();
for (Row row : rows)
{
    System.out.format(" %3.1f %n", row.getCellsCopy().get(0).getDouble());
}
System.out.println();
System.out.format("<Found %d records>%n", rows.size());
System.out.println();
}

        client.shutdown();
	// System.exit(0);
    }
}

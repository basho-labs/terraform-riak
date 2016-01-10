import java.net.UnknownHostException;
import java.util.concurrent.ExecutionException;
import com.basho.riak.client.api.RiakClient;
import com.basho.riak.client.api.commands.timeseries.Query;
import com.basho.riak.client.core.query.timeseries.*;
import java.util.*;

public class TSQuery {
    public static void main(String [] args) throws UnknownHostException, ExecutionException, InterruptedException {

        RiakClient client = RiakClient.newClient(8087, args[0]);

        String queryText = "Select time, weather, temperature from " + args[1] + " where " +
                   "myfamily = 'family1' and myseries = 'series1' and " +
                   "time >= 1420113600000 and time <= 1420113900000";

        Query query = new Query.Builder(queryText).build();
        QueryResult queryResult = client.execute(query);

        List<Row> rows = queryResult.getRowsCopy();

        System.out.println();
        System.out.println();

        for (Row row : rows)
        {
            Long time = row.getCellsCopy().get(0).getTimestamp();
            String weather = row.getCellsCopy().get(1).getVarcharAsUTF8String();
            Double temperature = row.getCellsCopy().get(2).getDouble();

            System.out.format(" %10d, %7s, %3.1f %n", time, weather, temperature);
        }

        System.out.println();
        System.out.format("<Found %d records>%n", rows.size());

        client.shutdown();
    }
}

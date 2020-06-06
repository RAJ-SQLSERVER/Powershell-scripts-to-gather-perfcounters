
while ($true)

{

$name = get-content C:\users\wangchenxu3\sqlservername.txt
$status  =  (get-service -computer $name -name MSSQLSERVER).status

$InsertSQL2 = " truncate table PerfStatus "
      $connectionString3="data source=10.199.83.40;database=PERFDB;uid=perfuser;pwd=perfuser;"
      $conn2=new-object system.Data.SqlClient.SqlConnection($connectionString3)
      $conn2.open()
 
      $cmd2=$conn2.CreateCommand()
 
       $cmd2.CommandText=$InsertSQL2
       $cmd2.ExecuteNonQuery()
       $conn2.Close()

foreach( $item in $name)
 
 {    

$status  = (get-service -computer $item -name MSSQLSERVER).status
$InsertSQL =""
$InsertSQL += ""
$InsertSQL += "INSERT INTO PerfStatus (Computer,Status,CaptureTime)"
$InsertSQL +=   " VALUES('$item','$status', getdate());"

      $connectionString3="data source=10.199.83.40;database=PERFDB;uid=perfuser;pwd=perfuser;"
      $conn2=new-object system.Data.SqlClient.SqlConnection($connectionString3)
      $conn2.open()
 
      $cmd2=$conn2.CreateCommand()
 
       $cmd2.CommandText=$InsertSQL
       $cmd2.ExecuteNonQuery()
       $conn2.Close()

}
  write-host "#######Probing#######" -ForegroundColor Green
  sleep 60

 }

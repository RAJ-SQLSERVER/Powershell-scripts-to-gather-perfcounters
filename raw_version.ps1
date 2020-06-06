while ($true)

{

$computername = get-content C:\users\wangchenxu3\servername.txt


$all= (get-counter -ComputerName (get-content C:\users\wangchenxu3\servername.txt) `
 -Counter "\PhysicalDisk(_Total)\Avg. Disk sec/Write").counterSamples | `
 select path , cookedValue



      $InsertSQL=""
      $curentTime=Get-Date
      
      foreach($PerformanceCounter in $all)
      {
            
          $realvalue=$PerformanceCounter.CookedValue
          $path = $PerformanceCounter.path
          #$value = $realvalue.ToString()

          $InsertSQL+="INSERT INTO PerfTable(Path,Value,TimeStamp)
          VALUES('$path','$realvalue','$curentTime');"
     #VALUES(''"+$path+"'',''"+$curentTime+"'',''"+$realvalue.ToString()+"'');"      
       }
      $connectionString3="data source=10.199.83.40;database=PERFDB;uid=perfuser;pwd=perfuser;"
      $conn2=new-object system.Data.SqlClient.SqlConnection($connectionString3)
      $conn2.open()
 
      $cmd2=$conn2.CreateCommand()
 
       $cmd2.CommandText=$InsertSQL
       $cmd2.ExecuteNonQuery()
       $conn2.Close()


       sleep 15

       }
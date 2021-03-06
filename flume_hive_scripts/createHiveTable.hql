use twitter;
ADD JAR /srv/hive/lib/hive-serdes-1.0-SNAPSHOT.jar;
ADD JAR /srv/hive/hcatalog/share/hcatalog/hive-hcatalog-core-0.14.0.jar;

 CREATE EXTERNAL TABLE tweets (
   id BIGINT,
   created_at STRING,
   source STRING,
   favorited BOOLEAN,
   retweeted_status STRUCT<
     text:STRING,
     user:STRUCT<screen_name:STRING,name:STRING>,
     retweet_count:INT>,
   entities STRUCT<
     urls:ARRAY<STRUCT<expanded_url:STRING>>,
     user_mentions:ARRAY<STRUCT<screen_name:STRING,name:STRING>>,
     hashtags:ARRAY<STRUCT<text:STRING>>>,
   text STRING,
   user STRUCT<
     screen_name:STRING,
     name:STRING,
     friends_count:INT,
     followers_count:INT,
     statuses_count:INT,
     verified:BOOLEAN,
     utc_offset:INT,
     time_zone:STRING>,
   in_reply_to_screen_name STRING
 ) 
 PARTITIONED BY (datehour INT)
 ROW FORMAT SERDE 'com.cloudera.hive.serde.JSONSerDe'
 WITH SERDEPROPERTIES(
	'mapping.value' = 'value'
 )
 LOCATION '/user/flume/tweets';

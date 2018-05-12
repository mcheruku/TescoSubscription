/*
	Created By:       Robin
	Date created:     14-Aug-2013
	Purpose:          Insert records to table [tescosubscription].[ConfigurationSettings]
	Usage:            Data used for subscriptions 
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On   Changed By        Defect            Description
    23-Apr-2014  Saritha Kommineni                   Config added  for RenewalInProgressAttempts
	14-Apr-2014  Robin                               Duration spelling Correction 
	18 -June-2014 Robin                              Removed previous entries and added update personalizesavings setting value
*/ 


SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
                [SettingName] [varchar](255) NOT NULL,
                [SettingValue] [varchar](255) NOT NULL,
                [UTCCreatedDateTime] [datetime] NOT NULL,
                [UTCUpdatedDateTime] [datetime] NOT NULL,
CONSTRAINT [PK_SettingName] PRIMARY KEY CLUSTERED  
(
                [SettingValue] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_ConfigurationSettings_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_ConfigurationSettings_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
                SettingName,
                SettingValue)


SELECT 'RenewalInProgressAttempts',2
UNION ALL
SELECT 'SuspendedToCancelledStatusDuration',42

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[ConfigurationSettings] DestTable
ON  ToInsert.SettingValue = DestTable.SettingValue

INSERT INTO [tescosubscription].[ConfigurationSettings](
                SettingName,
                SettingValue,
                UTCCreatedDateTime,
                UTCUpdatedDateTime)
SELECT 
                ToInsert.SettingName,
                ToInsert.SettingValue,
                ToInsert.UTCCreatedDateTime,
                ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[ConfigurationSettings] DestTable
ON  ToInsert.SettingValue = DestTable.SettingValue
WHERE DestTable.SettingValue Is Null

SET @inserted = @@ROWCOUNT


UPDATE [tescosubscription].[ConfigurationSettings]
SET  SettingValue = 0 WHERE SettingName = 'IsPersonalizeSaving' 


PRINT 'UPDATED - SettingValue to 0 for IsPersonalizeSaving' 
PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[ConfigurationSettings].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[ConfigurationSettings].'

DROP TABLE #INSERTDATA

GO


GO

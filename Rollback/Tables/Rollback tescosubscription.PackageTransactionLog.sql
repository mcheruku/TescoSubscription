/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Table Type:		Transactional
	Purpose:		Roll back script for [tescosubscription].[packageTransactionLog]for current label
	

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[packageTransactionLog]',N'U') IS NULL
	BEGIN

	CREATE TABLE [tescosubscription].[packageTransactionLog]
                  (
                  [PackageTransactionLogID]   BIGINT IDENTITY(1,1) NOT NULL,
                  [PackageExecutionHistoryID] BIGINT  NOT NULL,
                  [TransactionRefrenceID]	  BIGINT NOT NULL,
                  [UTCCreatedDateTime]        DATETIME NOT NULL CONSTRAINT [DF_packageTransactionLog_UTCCreatedDateTime]  DEFAULT (getutcdate()),
    CONSTRAINT [PK_packageTransactionLog] PRIMARY KEY CLUSTERED 
(
     [packageTransactionLogID] DESC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

IF OBJECT_ID(N'[tescosubscription].[packageTransactionLog]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[packageTransactionLog] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[packageTransactionLog] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[packageTransactionLog] already exists.'
	END
GO

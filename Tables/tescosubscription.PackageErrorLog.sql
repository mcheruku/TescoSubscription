/*

	Author:			Saritha Kommineni
	Date created:	22-Aug-2011
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Create Lookup Table for PackageMaster 
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageErrorLog]',N'U') IS NULL
	BEGIN

CREATE TABLE [tescosubscription].[PackageErrorLog](
			 [PackageErrorLogID]  BIGINT IDENTITY(1,1) NOT NULL,
			 [PackageExecutionHistoryID]     BIGINT  NOT NULL,
			 [ErrorID]          BIGINT ,			
             [ErrorDescription] NVARCHAR(2048) NOT NULL,
             [ErrorDateTime] DATETIME,
CONSTRAINT [PK_PackageErrorLog] PRIMARY KEY CLUSTERED 
(
      [PackageErrorLogID] DESC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF OBJECT_ID(N'[tescosubscription].[PackageErrorLog]',N'U') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Table [tescosubscription].[PackageErrorLog] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Table [tescosubscription].[PackageErrorLog] not created.',16,1)
		END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[PackageErrorLog] already exists.'
	END
GO

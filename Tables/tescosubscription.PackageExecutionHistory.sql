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
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[PackageExecutionHistory]
                  (
                  [PackageExecutionHistoryID]	 BIGINT IDENTITY(1,1) NOT NULL,
                  [PackageID]		 SMALLINT NOT NULL,
                  [PackageStartTime] DATETIME NOT NULL,
                  [PackageEndTime]   DATETIME NULL,
                  [statusID]         TINYINT NOT NULL DEFAULT (12),
CONSTRAINT [PK_PackageExecutionHistory] PRIMARY KEY CLUSTERED 
(
     [PackageExecutionHistoryID] DESC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PackageExecutionHistory] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PackageExecutionHistory] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[PackageExecutionHistory] already exists.'
	END
GO

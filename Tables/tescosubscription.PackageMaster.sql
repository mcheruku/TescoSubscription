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
IF OBJECT_ID(N'[tescosubscription].[PackageMaster]',N'U') IS NULL
	BEGIN

		 CREATE TABLE [tescosubscription].[PackageMaster]
              (
              [PackageID] SMALLINT NOT NULL,
              [PackageName] VARCHAR(100) NOT NULL,
              [PackageDescription] [varchar](250) NULL, 
              [UTCCreatedDateTime] DATETIME NOT NULL CONSTRAINT [DF_PackageMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()),
	          [UTCUpdatedDateTime] DATETIME NOT NULL CONSTRAINT [DF_PackageMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()),
		 CONSTRAINT [PK_PackageMaster] PRIMARY KEY CLUSTERED 
              (
			  [PackageID] DESC
		 )WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		 ) ON [PRIMARY]

  IF OBJECT_ID(N'[tescosubscription].[PackageMaster]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PackageMaster] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PackageMaster] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[PackageMaster] already exists.'
	END
GO

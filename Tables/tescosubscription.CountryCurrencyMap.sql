/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Create Lookup Table for country currency
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyMap]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[CountryCurrencyMap](
			[CountryCurrencyID] [tinyint] NOT NULL,
			[CountryCode] [char](2) NOT NULL,
			[CountryCurrency] [char](3) NOT NULL,
			[CurrencyDesc] [varchar](30) NULL,
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_CountryMaster] PRIMARY KEY CLUSTERED 
		(
			[CountryCurrencyID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
		 CONSTRAINT [UK_CountryMaster] UNIQUE NONCLUSTERED 
		(
			[CountryCode] ASC,
			[CountryCurrency] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[CountryCurrencyMap] ADD  CONSTRAINT [DF_CountryCurrencyMap_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[CountryCurrencyMap] ADD  CONSTRAINT [DF_CountryCurrencyMap_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyMap]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CountryCurrencyMap] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CountryCurrencyMap] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[CountryCurrencyMap] already exists.'
	END
GO


/*

	Author:			Robin John
	Date created:	29-11-2012
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
         
*/



IF OBJECT_ID(N'[tescosubscription].[PaymentInstallment]',N'U') IS NULL
BEGIN
CREATE TABLE [tescosubscription].[PaymentInstallment](
	[PaymentInstallmentID] [tinyint] NOT NULL,
	[PaymentInstallmentName] [varchar](100)  NOT NULL,
	[InstallmentTenure] [tinyint] NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_PaymentInstallment_UTCCreatedDateTime]  DEFAULT (getutcdate()),
	[UTCUpdatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_PaymentInstallment_UTCUpdatedDateTime]  DEFAULT (getutcdate()),
 CONSTRAINT [PK_PaymentInstallment] PRIMARY KEY CLUSTERED 
(
	[PaymentInstallmentID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF OBJECT_ID(N'[tescosubscription].[PaymentInstallment]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PaymentInstallment] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PaymentInstallment] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[PaymentInstallment] already exists.'
	END
GO
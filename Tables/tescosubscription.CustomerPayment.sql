/*

	Author:			Rajendra Singh
	Date created:	27-Jul-2011
	Table Type:		Transactional
	Purpose:		saves payment details of customers
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	25 Aug 2011		Manjunathan						Made Is Active default as 0

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[CustomerPayment](
			[CustomerPaymentID] [bigint] IDENTITY(1,1) NOT NULL,
			[CustomerID] [bigint] NOT NULL,
			[PaymentModeID] [tinyint] NOT NULL,
			[PaymentToken] [nvarchar](44) NOT NULL,
			[IsActive] [bit] NOT NULL,
			[IsFirstPaymentDue] [bit] NOT NULL,
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_CustomerPayment] PRIMARY KEY CLUSTERED 
		(
			[CustomerPaymentID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[CustomerPayment] ADD  CONSTRAINT [DF_CustomerPayment_IsActive]  DEFAULT ((0)) FOR [IsActive]

		ALTER TABLE [tescosubscription].[CustomerPayment] ADD  CONSTRAINT [DF_CustomerPayment_IsFirstPaymentDue]  DEFAULT ((1)) FOR [IsFirstPaymentDue]

		ALTER TABLE [tescosubscription].[CustomerPayment] ADD  CONSTRAINT [DF_CustomerPayment_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[CustomerPayment] ADD  CONSTRAINT [DF_CustomerPayment_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerPayment] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerPayment] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[CustomerPayment] already exists.'
	END
GO

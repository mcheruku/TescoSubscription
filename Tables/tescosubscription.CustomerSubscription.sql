/*

	Author:			Rajendra Singh
	Date created:	27-Jul-2011
	Table Type:		Transactional
	Purpose:		Holds customers subscription details 
	Usage:			<How will this table be utilised>
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
    25 Aug 2011		Saritha							Added new column EmailSentRenewalDate
    09 May 2013     Robin                           Added 2 new coloumns


*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[CustomerSubscription](
			[CustomerSubscriptionID] [bigint] IDENTITY(1,1) NOT NULL,
			[CustomerID] [bigint] NOT NULL,
			[SubscriptionPlanID] [int] NOT NULL,
			[CustomerPlanStartDate] [datetime] NOT NULL,
			[CustomerPlanEndDate] [datetime] NOT NULL,
			[NextRenewalDate] [datetime] NOT NULL,
			[SubscriptionStatus] [tinyint] NOT NULL,
			[PaymentProcessStatus] [tinyint] NOT NULL,
			[RenewalReferenceDate] [datetime] NOT NULL,
			[EmailSentRenewalDate] DATETIME NOT NULL CONSTRAINT [DF_CustomerSubscription_EmailSentRenewalDate]  DEFAULT (((1)/(1))/(1900)), 
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_CustomerSubscription] PRIMARY KEY CLUSTERED 
		(
			[CustomerSubscriptionID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[CustomerSubscription] ADD  CONSTRAINT [DF_CustomerSubscription_PaymentProcessStatus]  DEFAULT ((6)) FOR [PaymentProcessStatus]

		ALTER TABLE [tescosubscription].[CustomerSubscription] ADD  CONSTRAINT [DF_CustomerSubscription_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[CustomerSubscription] ADD  CONSTRAINT [DF_CustomerSubscription_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerSubscription] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerSubscription] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[CustomerSubscription] already exists.'
	END
GO


--------------- ADD column [SwitchTo] ------------------------

IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'CustomerSubscription'
				AND COLUMN_NAME         = 'SwitchTo') 
BEGIN 
    
	ALTER TABLE [tescosubscription].[CustomerSubscription] ADD SwitchTo INT NULL
		PRINT 'Column tescosubscription.CustomerSubscription.SwitchTo added'
END
GO


--------------- ADD column [SwitchCustomerSubscriptionID] ------------------------

IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'CustomerSubscription'
				AND COLUMN_NAME         = 'SwitchCustomerSubscriptionID') 

BEGIN
  
     ALTER TABLE [tescosubscription].[CustomerSubscription] ADD SwitchCustomerSubscriptionID BIGINT NULL
		PRINT 'Column tescosubscription.CustomerSubscription.SwitchCustomerSubscriptionID added'
END
GO


--------------- ADD column [NextPaymentDate] ------------------------

IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'CustomerSubscription'
				AND COLUMN_NAME         = 'NextPaymentDate') 
BEGIN 
    
	ALTER TABLE [tescosubscription].[CustomerSubscription] ADD NextPaymentDate DATETIME NULL
		PRINT 'Column tescosubscription.CustomerSubscription.NextPaymentDate added'
END
GO



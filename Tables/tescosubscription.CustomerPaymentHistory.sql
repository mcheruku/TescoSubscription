/*

	Author:			Rajendra Singh
	Date created:	27-Jul-2011
	Table Type:		Transactional
	Purpose:		Holds Payment History of customers
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
    25 Aug 2011		Saritha							Added new column IsEmailSent
    06 JAn 2012     saritha							added new column PackageExecutionHistoryID
    14 Apr 2014     Robin                           added a new column IsPreAuth
       
*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[CustomerPaymentHistory](
			[CustomerPaymentHistoryID] [bigint] IDENTITY(1,1) NOT NULL,
			[CustomerPaymentID] [bigint] NOT NULL,
			[CustomerSubscriptionID] [bigint] NOT NULL,
			[PaymentDate] [datetime] NOT NULL,
			[PaymentAmount] [smallmoney] NOT NULL,
			[ChannelID] [tinyint] NOT NULL,
            [PackageExecutionHistoryID] [BIGINT] NULL,
			[IsEmailSent] [bit] NOT NULL CONSTRAINT [DF_CustomerPaymentHistory_IsEmailSent] DEFAULT ((0)), 
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_CustomerPaymentHistory] PRIMARY KEY CLUSTERED 
		(
			[CustomerPaymentHistoryID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[CustomerPaymentHistory] ADD  CONSTRAINT [DF_CustomerPaymentHistory_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[CustomerPaymentHistory] ADD  CONSTRAINT [DF_CustomerPaymentHistory_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]



		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerPaymentHistory] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerPaymentHistory] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[CustomerPaymentHistory] already exists.'
	END
GO


--------------- ADD column PackageExecutionHistoryID ------------------------

IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'CustomerPaymentHistory'
				AND COLUMN_NAME         = 'PackageExecutionHistoryID') 
BEGIN     
	ALTER TABLE [tescosubscription].[CustomerPaymentHistory] ADD PackageExecutionHistoryID BIGINT  NULL 
		PRINT 'Column tescosubscription.CustomerPaymentHistory.PackageExecutionHistoryID added'
END
GO

---------------Drop Columns PaymentStatusID and Remarks ----------------- 

-- DROP Column PaymentStatusID 

-- Drop COnstarint if exists

IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPaymentHistory_StatusMaster]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]'))
	BEGIN

		ALTER TABLE [tescosubscription].[CustomerPaymentHistory] DROP CONSTRAINT [FK_CustomerPaymentHistory_StatusMaster]

    End

GO
IF  EXISTS(SELECT 1 FROM  information_schema.columns      
				WHERE table_schema      = 'tescosubscription'
				AND table_name          = 'CustomerPaymentHistory'
				AND column_name         = 'PaymentStatusID') 
BEGIN     
	ALTER TABLE  [tescosubscription].[CustomerPaymentHistory] DROP COLUMN [PaymentStatusID] 
		PRINT 'Column [PaymentStatusID] dropped'
END
GO


-- DROP column [Remarks]

IF  EXISTS(SELECT 1 FROM  information_schema.columns      
				WHERE table_schema      = 'tescosubscription'
				AND table_name          = 'CustomerPaymentHistory'
				AND column_name         = 'Remarks') 
BEGIN     
	ALTER TABLE  [tescosubscription].[CustomerPaymentHistory] DROP COLUMN [Remarks] 
		PRINT 'Column [Remarks] dropped'
END
GO

--------------- ADD column [IsPreAuth] ------------------------


IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
                           WHERE TABLE_SCHEMA   = 'TescoSubscription'
                           AND TABLE_NAME       = 'CustomerPaymentHistory'
                           AND COLUMN_NAME      = 'IsPreAuth') 
BEGIN  
	ALTER TABLE [TescoSubscription].[CustomerPaymentHistory] 
	ADD IsPreAuth BIT NOT NULL CONSTRAINT [DF_CustomerPaymentHistory_IsPreAuth] DEFAULT ((0)) 
    PRINT 'Column TescoSubscription.CustomerPaymentHistory.IsPreAuth added'
END

GO



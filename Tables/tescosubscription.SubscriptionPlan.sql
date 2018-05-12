/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Table Type:		Reference
	Table Size:		Estimated <5000
	Purpose:		To hold subscription plans
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	
    01 Aug 2011		Saritha kommineni				[PlanName] data type length changed to [varchar](30) 
    03 Aug 2011		Saritha K						BasketValue datatype changed to SmallMoney
    04 Aug 2011		Saritha K						Removed uniuqe constraint on sort order column
    05 Aug 2011		Saritha K						Reverted back above unique constraint changes
    17 Aug 2011		Saritha K						Modified [SortOrder] datatype from tinyint to smallint
    17 Aug 2011		Saritha K						removed default value for PlanMaxUsage column
    29 Nov 2012     Robin						    Added [IsSlotRestricted] and [PaymentInstallmentID] columns
	17 jun 2013     Robin                           Changed the data type to 50 for plan name
*/


IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[SubscriptionPlan](
			[SubscriptionPlanID] [int] IDENTITY(1,1) NOT NULL,
			[CountryCurrencyID] [tinyint] NOT NULL,
			[BusinessID] [tinyint] NOT NULL,
			[SubscriptionID] [tinyint] NOT NULL,
			[PlanName] [varchar](30) NOT NULL,
			[PlanDescription] [varchar](255) NOT NULL,
			[SortOrder] [smallint] NOT NULL,
			[PlanTenure] [int] NOT NULL,
			[PlanEffectiveStartDate] [datetime] NOT NULL,
			[PlanEffectiveEndDate] [datetime] NOT NULL,
			[PlanAmount] [smallmoney] NOT NULL,
			[TermConditions] [varchar](500) NULL,
			[IsActive] [bit] NOT NULL,
			[RecurringMonths] [tinyint] NOT NULL,
			[PlanMaxUsage] [smallint] NOT NULL,
			[BasketValue] SMALLMONEY NOT NULL,
			[FreePeriod] [tinyint] NOT NULL,
            [IsSlotRestricted] [bit] NOT NULL CONSTRAINT [DF_SubscriptionPlan_IsSlotRestricted]  DEFAULT ((0)),
			[PaymentInstallmentID] [tinyint] NOT NULL CONSTRAINT [DF_SubscriptionPlan_PaymentInstallmentID]  DEFAULT ((1)),
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		  CONSTRAINT [PK_SubscriptionPlan] PRIMARY KEY CLUSTERED 
		(
			[SubscriptionPlanID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
		 CONSTRAINT [UK_SubscriptionPlan_SortOrder] UNIQUE NONCLUSTERED 
		(
			[SortOrder] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		
		ALTER TABLE [tescosubscription].[SubscriptionPlan] ADD  CONSTRAINT [DF_SubscriptionPlan_IsActive]  DEFAULT ((1)) FOR [IsActive]

		ALTER TABLE [tescosubscription].[SubscriptionPlan] ADD  CONSTRAINT [DF_SubscriptionPlan_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[SubscriptionPlan] ADD  CONSTRAINT [DF_SubscriptionPlan_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[SubscriptionPlan] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[SubscriptionPlan] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[SubscriptionPlan] already exists.'
	END
GO



--------------- ADD column [IsSlotRestricted] ------------------------

IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'SubscriptionPlan'
				AND COLUMN_NAME         = 'IsSlotRestricted') 
BEGIN     
	ALTER TABLE [tescosubscription].[SubscriptionPlan] ADD IsSlotRestricted BIT  NOT NULL CONSTRAINT [DF_SubscriptionPlan_IsSlotRestricted]  DEFAULT ((0))
		PRINT 'Column tescosubscription.SubscriptionPlan.IsSlotRestricted added'
END
GO



--------------- ADD column [PaymentInstallmentID] ------------------------

IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'SubscriptionPlan'
				AND COLUMN_NAME         = 'PaymentInstallmentID') 
BEGIN     
	ALTER TABLE [tescosubscription].[SubscriptionPlan] ADD PaymentInstallmentID TINYINT NOT NULL CONSTRAINT [DF_SubscriptionPlan_PaymentInstallmentID]  DEFAULT ((1)) 
		PRINT 'Column tescosubscription.SubscriptionPlan.PaymentInstallmentID added'
END
GO

--------------Alter column [PlanName]-------------------------------------
IF EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'SubscriptionPlan'
				AND COLUMN_NAME         = 'PlanName'
                AND CHARACTER_OCTET_LENGTH = 30) 
BEGIN     
	
ALTER TABLE [tescosubscription].[SubscriptionPlan]
ALTER COLUMN [PlanName] VARCHAR(50) NOT NULL

PRINT 'Column tescosubscription.SubscriptionPlan.PlanName altered'
END
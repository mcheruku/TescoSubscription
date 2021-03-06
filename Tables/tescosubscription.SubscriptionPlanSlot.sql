
/*

	Author:			Robin John
	Date created:	29-11-2012
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
         
*/



IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanSlot]',N'U') IS NULL
BEGIN

	CREATE TABLE [tescosubscription].[SubscriptionPlanSlot](
		[SubscriptionPlanID] [int] NOT NULL,
		[DOW] [tinyint] NOT NULL
	) ON [PRIMARY]

	

IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanSlot]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[SubscriptionPlanSlot] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[SubscriptionPlanSlot] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[SubscriptionPlanSlot] already exists.'
	END
GO


--------------Add Primary Key to Subscriptionplan and DOW-------------------------------------
IF EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'SubscriptionPlanSlot'
				AND COLUMN_NAME         = 'SubscriptionPlanID'
                ) 
BEGIN     
	
ALTER TABLE [tescosubscription].[SubscriptionPlanSlot]
ADD CONSTRAINT PK_SubscriptionPlanSlot_SubscriptionPlanID_DOW PRIMARY KEY (SubscriptionPlanID,DOW)

PRINT 'PK_SubscriptionPlanSlot_SubscriptionPlanID_DOW Created'
END
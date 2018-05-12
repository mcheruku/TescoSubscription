
/*

	Created By:	Saritha Kommineni
	Date created:	18 Jan 2012
	Purpose:		Rollback To update PackageMaster table
	Usage:			(Specfic to current label)
	Data Type:	Hybrid

	--Modifications History--
	Changed On		Changed By		Defect		Description
	
*/



SET NOCOUNT ON

DECLARE  @updated  int,
		 @CurrentDateTime	datetime

SELECT	@updated = 0,
		@CurrentDateTime =getutcdate()


-- Update packageName to RenewCustomerSubscriptions.dtsx
IF EXISTS(SELECT 1 FROM [tescoSubscription].[PackageMaster] WHERE  [packageID]= 1 and [PackageName] ='TescoSubscriptionRecurringPayment' )
	BEGIN
	
	      SET @updated = @updated + 1

		UPDATE  [tescoSubscription].[PackageMaster]
		SET     [PackageName] ='RenewCustomerSubscriptions.dtsx',
		        [utcupdateddatetime]=@CurrentDateTime
		WHERE   [packageID]= 1
		AND		[PackageName] ='TescoSubscriptionRecurringPayment'
	
	END
	
-- Update packageName to TescoSubscriptionNotification  NotifyCustomerSubscriptions.dtsx
IF EXISTS(SELECT 1 FROM [tescoSubscription].[PackageMaster] WHERE [packageID]= 2 and [PackageName] ='TescoSubscriptionNotification')
	BEGIN
	
		SET  @updated = @updated + 1

	UPDATE  [tescoSubscription].[PackageMaster]
		SET     [PackageName] ='NotifyCustomerSubscriptions.dtsx',
		        [utcupdateddatetime]=@CurrentDateTime
		WHERE   [packageID]= 2
		AND		[PackageName] ='TescoSubscriptionNotification'

	  END


PRINT 'UPDATED - ' + CONVERT(varchar(10), @updated) + ' record(s) in [tescoSubscription].[PackageMaster].'
GO








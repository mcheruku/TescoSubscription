USE [TescoSubscription]
GO
IF OBJECT_ID(N'[tescosubscription].[PreviousInProgressToActive]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PreviousInProgressToActive]

		IF OBJECT_ID(N'[tescosubscription].[PreviousInProgressToActive]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PreviousInProgressToActive] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PreviousInProgressToActive] not dropped.',16,1)
			END
	END
 GO
CREATE PROCEDURE	[tescosubscription].[PreviousInProgressToActive] 

/*

	Author:			Robin
	Date created:	06 Nov 2014
	Purpose:		To get all the Previous InProgress Status   Subscription
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		 
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	    
*/
AS

DECLARE @CutoffDay DATETIME,
@ActivePaymentprocessSattus INT,
@InprogressPaymentSatus INT,
@ActiveSubscriptionSattus INT,
@PendingStopStatus INT,
@EndOfDay DATETIME,
@RenewalInProgressAttempts SMALLINT,
@YestDate DATETIME,
@RenewalAttempts DATETIME

SELECT @RenewalInProgressAttempts = CONVERT(SMALLINT,SettingValue) FROM [tescosubscription].[ConfigurationSettings] 
                                     WHERE SettingName = 'RenewalInProgressAttempts'


SELECT @ActivePaymentprocessSattus=6,
@InprogressPaymentSatus=5,
@ActiveSubscriptionSattus=8,
@PendingStopStatus=11,
@YestDate =  CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE()-1, 101) + ' 23:59:59'),
@RenewalAttempts  = CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE()-(@RenewalInProgressAttempts+1), 101) + ' 23:59:59')

UPDATE tescosubscription.customersubscription
SET paymentprocessstatus=@ActivePaymentprocessSattus,
Utcupdateddatetime=GETUTCDATE()
WHERE paymentprocessstatus = @InprogressPaymentSatus
AND (Subscriptionstatus=@ActiveSubscriptionSattus
	 OR Subscriptionstatus=@PendingStopStatus
	)
AND UTCUpdatedDatetime BETWEEN @RenewalAttempts AND @YestDate
 


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PreviousInProgressToActive] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[PreviousInProgressToActive]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[PreviousInProgressToActive] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[PreviousInProgressToActive] not created.',16,1)
	END
GO
    

 

 
 



IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionStopStatusUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionStopStatusUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionStopStatusUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionStopStatusUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionStopStatusUpdate] not dropped.',16,1)
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionStopStatusUpdate]

AS

/*

	Author:		   Saritha Kommineni
	Date created:  25 Aug 2011
	Purpose:	   Updates subscriptions with status 'pending stop' to 'Stopped'	
	Behaviour:		
	Usage:			
	Called by:		
	WarmUP Script:	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	

*/

BEGIN
			
SET NOCOUNT ON

DECLARE @Stopped TINYINT
	   ,@PendingStop TINYINT

-- Below Assigned values are status Id reference data from status master table
SELECT  @Stopped=10, 
        @PendingStop=11


  -- Updates subscriptions with status 'pending stop' to 'Stopped'

		UPDATE tescosubscription.CustomerSubscription
		SET    SubscriptionStatus= @Stopped,
               UTCUpdatedDateTime= GetUTCDate()
        WHERE  CustomerPlanEndDate < CONVERT(DATETIME,CONVERT(VARCHAR(10),GETDATE(),101) + ' 23:59:59')
        AND    SubscriptionStatus=@PendingStop  

END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionStopStatusUpdate] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionStopStatusUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionStopStatusUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionStopStatusUpdate] not created.',16,1)
	END
GO

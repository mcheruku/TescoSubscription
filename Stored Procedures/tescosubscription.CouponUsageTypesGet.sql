IF OBJECT_ID(N'[tescosubscription].[CouponUsageTypesGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CouponUsageTypesGet]

		IF OBJECT_ID(N'[tescosubscription].[CouponUsageTypesGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CouponUsageTypesGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CouponUsageTypesGet] not dropped.',16,1)
			END
	END
GO 
CREATE PROCEDURE [tescosubscription].[CouponUsageTypesGet] 
AS

/*

	Author:			Deepmala Trivedi
	Date created:	03 Apr 2014
	Purpose:		To get all the coupon usage types
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	    
*/

BEGIN
	SET NOCOUNT ON		

	SELECT UsageTypeId, UsageName FROM Coupon.CouponUsageType WITH (NOLOCK)
		
END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CouponUsageTypesGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CouponUsageTypesGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CouponUsageTypesGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CouponUsageTypesGet] not created.',16,1)
	END
GO
    

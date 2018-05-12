IF OBJECT_ID(N'[Coupon].[CouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponGet]

		IF OBJECT_ID(N'[Coupon].[CouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponGet] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [Coupon].[CouponGet]
(
	@CouponCode				NVARCHAR(25)	
)
AS

/*
	Author:		Shilpa
	Created:	18/Sep/2012
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
	
BEGIN

	SET NOCOUNT ON;	
	

	SELECT pvt.Amount, pvt.[2] EffectiveStartDateTime, Pvt.[3] EffectiveEndDateTime FROM
	(
		SELECT 
			AttributeValue,
			AttributeID,
			c.Amount
		FROM Coupon.coupon c (NOLOCK) JOIN		
			coupon.CouponAttributes ca (NOLOCK) ON ca.CouponID = c.CouponID
		WHERE c.CouponCode = @CouponCode 
	) A
	PIVOT (
		 MIN(Attributevalue)
		 FOR AttributeID in ([2],[3])
	) pvt
 

END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponGet] not created.',16,1)
	END
GO

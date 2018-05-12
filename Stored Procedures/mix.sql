USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignCodeGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCodeGetAll]

		IF OBJECT_ID(N'[Coupon].[CampaignCodeGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCodeGetAll] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCodeGetAll] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignCodeGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignCodeGetAll]
** DATE WRITTEN   : 27/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignCodeGetAll] 

AS

BEGIN

SET NOCOUNT ON;
DECLARE @ErrorMessage		NVARCHAR(2048)

BEGIN TRY

	SELECT CampaignCode from Coupon.Campaign
			
END TRY	
BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()

		RAISERROR (
				'SP - [coupon].[CampaignCodeGetAll] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
END CATCH

END
GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignCodeGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignCodeGetAll]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignCodeGetAll] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignCodeGetAll] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCountGetAll]

		IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCountGetAll] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCountGetAll] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignCountGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignCountGetAll]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE Coupon.CampaignCountGetAll
AS

BEGIN

	SELECT COUNT(CampaignID) AS CampaignCount FROM Coupon.Campaign

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignCountGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignCountGetAll] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignCountGetAll] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCouponGet]

		IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCouponGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignCouponGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignCouponGet]
** DATE WRITTEN   : 25/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignCouponGet] 
(
@CampaignID				BIGINT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @CampaignTypeID			INT
	
BEGIN TRY

	SELECT @CampaignTypeID = C.CampaignTypeID 
	FROM
		Coupon.Campaign C
	WHERE C.CampaignID = @CampaignID 
	
	IF (@@ROWCOUNT  = 0)
		BEGIN
			SET @ErrorMessage = 'Unable to Determine CampaignTypeID for the supplied CampaignID'
					
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
	ELSE
		BEGIN
			IF (@CampaignTypeID = 1 OR @CampaignTypeID = 2)--Naive or Unique Coupons
				BEGIN

					SELECT Cpn.CouponCode
						FROM Coupon.Coupon Cpn
						WHERE Cpn.CampaignID = @CampaignID
					
				END
			ELSE IF(@CampaignTypeID = 3)
				BEGIN
					--Getting the list of CustomerID with linked Coupon Code
					SELECT Cm.CustomerID
							,Cpn.CouponCode
						FROM Coupon.Coupon Cpn
						INNER JOIN Coupon.CouponCustomerMap Cm
							ON Cm.CouponID = Cpn.CouponID
							AND Cpn.CampaignID = @CampaignID

				END
			END
		END TRY
		BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
				
				RAISERROR (
						'SP - [coupon].[CampaignCouponGet] Error = (%s)',
						16,
						1,
						@ErrorMessage
						)			
		END CATCH
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignCouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignCouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignCouponGet] not created.',16,1)
	END
GO
	

USE [TescoSubscription]
GO
/****** Object:  StoredProcedure [Coupon].[CampaignDetailsGetAll]    Script Date: 06/12/2013 07:14:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsGetAll]

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetAll] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignDetailsGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[CampaignDetailsGetAll]
** DATE WRITTEN   : 06/04/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): DATA OF TABLE [Coupon].[CampaignDetailsGetAll] WHICH IS ACTIVE
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	20 Jun 2013		Navdeep_Singh	131642			Modified Decimal Conversion parameters - 'Cost Associated'
	02 Jul 2013		Navdeep_Singh	NA				Development: Changed to incorporate req. for View Coupon Story
	04 Jul 2013		Navdeep_Singh	NA				Development: Changed to include CampaignTypeID and ExternalDescription for View Coupon Story
*/

CREATE PROCEDURE [Coupon].[CampaignDetailsGetAll] 
(
@CampaignID BIGINT = NULL
)
AS

BEGIN
SET NOCOUNT ON

DECLARE @ErrorMessage    NVARCHAR(2048)

BEGIN TRY
			IF (@CampaignID IS NULL)
			BEGIN
				SET @CampaignID = 0
			END
			
			SELECT 	TempCampaignDetails.CampaignID
					,TempCampaignDetails.UTCCreatedDateTime
					,TempCampaignDetails.CampaignCode
					,TempCampaignDetails.CampaignTypeName
					,TempCampaignDetails.CampaignTypeID
					,TempCampaignAttributes.SubscriptionPlanId 
					,ISNULL(TempCampaignDetails.DescriptionShort,'') AS [InternalDescription]
					,ISNULL(TempCampaignDetails.DescriptionLong,'') AS [ExternalDescription]			
					,TempCampaignAttributes.[CouponsGeneratedCount]
					,ISNULL(TempCouponDetails.[Redemptions],0) AS [Redemptions]
					,ISNULL(TempCampaignDetails.[AmountOff],0)	AS [AmountOff]		
					,ISNULL(CONVERT(DECIMAL(38,2),(TempCouponDetails.[Redemptions] * [AmountOff])),0) AS [CostAssociated]
					,TempCampaignDetails.IsActive
					,TempCampaignAttributes.EffectiveStartDateTime
					,TempCampaignAttributes.EffectiveEndDateTime 
					,TempCampaignAttributes.MaxRedemption
					,TempCampaignAttributes.LapsePeriod	
			FROM
				(
				SELECT	C.CampaignID
						,C.UTCCreatedDateTime
						,CampaignCode
						,C.CampaignTypeID
						,CTM.CampaignTypeName
						,C.DescriptionShort
						,C.DescriptionLong
						,C.Amount AS [AmountOff]
						,C.IsActive												
				 FROM Coupon.Campaign C (NOLOCK)
				INNER JOIN Coupon.CampaignTypeMaster CTM (NOLOCK)
					On C.CampaignTypeID = CTM.CampaignTypeID		
				)TempCampaignDetails
				LEFT OUTER JOIN (SELECT	Cpn.CampaignID
										,Sum (Cpn.RedeemCount) AS [Redemptions]								
								FROM Coupon.Coupon Cpn						
								GROUP BY CampaignID
								)TempCouponDetails
				ON TempCampaignDetails.CampaignID = TempCouponDetails.CampaignID
				LEFT OUTER JOIN (
								SELECT PVT.CampaignId
										,PVT.[1] SubscriptionPlanId
										,PVT.[2] EffectiveStartDateTime
										,PVT.[3] EffectiveEndDateTime
										,PVT.[4] MaxRedemption
										,PVT.[5] LapsePeriod
										,PVT.[6] CouponsGeneratedCount 
								FROM
									(
									SELECT C.CampaignId,
											AttributeValue,
											AttributeID			
									FROM Coupon.Campaign C 
									JOIN Coupon.CampaignAttributes CA
										ON ca.CampaignID = c.CampaignID			
									) A
									PIVOT (
										 MIN(Attributevalue)
										 FOR AttributeID in ([1],[2],[3],[4],[5],[6])
									) PVT
								)TempCampaignAttributes
									ON TempCampaignAttributes.CampaignID=TempCampaignDetails.CampaignID		
						WHERE @CampaignID = 0 OR TempCampaignDetails.CampaignID = @CampaignID
						ORDER BY TempCampaignDetails.UTCCreatedDateTime DESC,TempCampaignDetails.CampaignID DESC
		END TRY

		BEGIN CATCH
				SET @ErrorMessage = ERROR_MESSAGE()	
			
				RAISERROR (
				'SP - [Coupon].[CampaignDetailsGetAll] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
		END CATCH;
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetAll] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll1]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CampaignDetailsGetAll1]
    
    IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll1]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll1] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CampaignDetailsGetAll1] not dropped.',
            16,
            1
        )
    END
END

GO

CREATE PROCEDURE [Coupon].[CampaignDetailsGetAll1] 
(
@CampaignID NVARCHAR(300) = NULL
)
AS

/*
	Author:		Robin
	Created:	17/March/2014
	Purpose:	Get Campaign Details
    Called By:  Coupon Service

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
SET NOCOUNT ON

DECLARE
@ErrorMessage    NVARCHAR(2048)
,@Delimiter    NVARCHAR(1)
,@String       NVARCHAR(25)

SET @Delimiter = ','

DECLARE 
@CouponTable  TABLE (String NVARCHAR(44))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CampaignID,@Delimiter))


BEGIN TRY
			IF (@CampaignID IS NULL)
			BEGIN
				SET @CampaignID = 0
			END
			
			SELECT 	TempCampaignDetails.CampaignID
					,TempCampaignDetails.UTCCreatedDateTime
					,TempCampaignDetails.CampaignCode
					,TempCampaignDetails.CampaignTypeName
					,TempCampaignDetails.CampaignTypeID
					,ISNULL(TempCampaignDetails.DescriptionShort,'') AS [InternalDescription]
					,ISNULL(TempCampaignDetails.DescriptionLong,'') AS [ExternalDescription]			
					,TempCampaignAttributes.[CouponsGeneratedCount]
					,ISNULL(TempCouponDetails.[Redemptions],0) AS [Redemptions]
					,ISNULL(CONVERT(DECIMAL(38,2),(TempCouponDetails.[Redemptions] * [AmountOff])),0) AS [CostAssociated]
					,TempCampaignDetails.IsActive
					,TempCampaignAttributes.EffectiveStartDateTime
					,TempCampaignAttributes.EffectiveEndDateTime 
					,TempCampaignAttributes.MaxRedemption
					,TempCampaignAttributes.LapsePeriod	
                    ,TempCampaignAttributes.CouponsGeneratedCount 
                    ,TempCampaignAttributes.IsClubCardBoost
                    ,TempCampaignAttributes.ClubCardVoucherValue
                    ,TempCampaignDetails.UsageTypeID
                    ,TempCampaignDetails.IsMutuallyExclusive
                    ,TempCampaignDetails.UsageName
			FROM
				(
				SELECT	C.CampaignID
						,C.UTCCreatedDateTime
						,CampaignCode
						,C.CampaignTypeID
						,CTM.CampaignTypeName
						,C.DescriptionShort
						,C.DescriptionLong
                        ,C.Amount AS [AmountOff]
						,C.IsActive	
                        ,C.UsageTypeID
                        ,C.IsMutuallyExclusive
                        ,UT.UsageName
                FROM Coupon.Campaign C (NOLOCK)
				INNER JOIN Coupon.CampaignTypeMaster CTM (NOLOCK)
					On C.CampaignTypeID = CTM.CampaignTypeID
                INNER JOIN Coupon.CouponUsageType UT
                    ON C.UsageTypeID = UT.UsageTypeID	
				)TempCampaignDetails
				LEFT OUTER JOIN (SELECT	Cpn.CampaignID
										,Sum (Cpn.RedeemCount) AS [Redemptions]								
								FROM Coupon.Coupon Cpn						
								GROUP BY CampaignID
								)TempCouponDetails
				ON TempCampaignDetails.CampaignID = TempCouponDetails.CampaignID
				LEFT OUTER JOIN (
								SELECT PVT.CampaignId
										,PVT.[2] EffectiveStartDateTime
										,PVT.[3] EffectiveEndDateTime
										,PVT.[4] MaxRedemption
										,PVT.[5] LapsePeriod
										,PVT.[6] CouponsGeneratedCount 
                                        ,PVT.[7] IsClubCardBoost
                                        ,PVT.[8] ClubCardVoucherValue
								FROM
									(
									SELECT C.CampaignId,
											AttributeValue,
											AttributeID			
									FROM Coupon.Campaign C 
									JOIN Coupon.CampaignAttributes CA
										ON ca.CampaignID = c.CampaignID			
									) A
									PIVOT (
										 MIN(Attributevalue)
										 FOR AttributeID in ([2],[3],[4],[5],[6],[7],[8])
									) PVT
								)TempCampaignAttributes
									ON TempCampaignAttributes.CampaignID=TempCampaignDetails.CampaignID		
						WHERE @CampaignID IN (Select String FROM @CouponTable) OR TempCampaignDetails.CampaignID IN (Select String FROM @CouponTable)
						ORDER BY TempCampaignDetails.UTCCreatedDateTime DESC,TempCampaignDetails.CampaignID DESC

SELECT DT.CampaignID
,DT.DiscountTypeID
,DT.DiscountValue 
,TM.DiscountName
FROM Coupon.CampaignDiscountType DT WITH (NOLOCK)
INNER JOIN Coupon.DiscountTypeMaster TM  WITH (NOLOCK)
ON DT.DiscountTypeID = TM.DiscountTypeID
WHERE DT.CampaignID IN (Select String FROM @CouponTable)

SELECT CampaignID
,SubscriptionPlanID
From Coupon.CampaignPlanDetails WITH(NOLOCK)
WHERE CampaignID IN (Select String FROM @CouponTable)


		END TRY

		BEGIN CATCH
				SET @ErrorMessage = ERROR_MESSAGE()	
			
				RAISERROR (
				'SP - [Coupon].[CampaignDetailsGetAll] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
		END CATCH;
END
 
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsGetAll1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll1]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll1] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CampaignDetailsGetAll1] not created.',
        16,
        1
    )
END
GO




USE [TescoSubscription]
GO
/****** Object:  StoredProcedure [Coupon].[CampaignDetailsGetPage]    Script Date: 06/12/2013 07:14:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsGetPage]

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetPage] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetPage] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignDetailsGetPage]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[CampaignDetailsGetPage]
** DATE WRITTEN   : 12 July 2013
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): DATA OF TABLE [Coupon].[CampaignDetailsGetPage] WHICH IS ACTIVE
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
*/

CREATE PROCEDURE [Coupon].[CampaignDetailsGetPage] 
(
@Start		INT
,@PageSize	INT
)
AS

BEGIN
SET NOCOUNT ON

DECLARE @ErrorMessage    NVARCHAR(2048)

BEGIN TRY


		;WITH TempCampaignAttributes
		AS
		(
			SELECT PVT.CampaignId
				,PVT.[1] SubscriptionPlanId
				,PVT.[2] EffectiveStartDateTime
				,PVT.[3] EffectiveEndDateTime
				,PVT.[4] MaxRedemption
				,PVT.[5] LapsePeriod
				,PVT.[6] CouponsGeneratedCount 
			FROM
			(
			SELECT C.CampaignId,
					AttributeValue,
					AttributeID			
			FROM Coupon.Campaign C 
			JOIN Coupon.CampaignAttributes CA
				ON ca.CampaignID = c.CampaignID			
			) A
			PIVOT (
				 MIN(Attributevalue)
				 FOR AttributeID in ([1],[2],[3],[4],[5],[6])
			) PVT
		)
		
		SELECT * FROM(			
		SELECT ROW_NUMBER() OVER (ORDER BY TempT.UTCCreatedDateTime DESC
										,TempT.CampaignID DESC)
						AS RowNumber
				, TempT.*
			FROM(
			SELECT 	TempCampaignDetails.CampaignID
					,TempCampaignDetails.UTCCreatedDateTime
					,TempCampaignDetails.CampaignCode
					,TempCampaignDetails.CampaignTypeName
					,TempCampaignDetails.CampaignTypeID
					,TempCampaignAttributes.SubscriptionPlanId 
					,ISNULL(TempCampaignDetails.DescriptionShort,'') AS [InternalDescription]
					,ISNULL(TempCampaignDetails.DescriptionLong,'') AS [ExternalDescription]			
					,TempCampaignAttributes.[CouponsGeneratedCount]
					,ISNULL(TempCouponDetails.[Redemptions],0) AS [Redemptions]
					,ISNULL(TempCampaignDetails.[AmountOff],0)	AS [AmountOff]		
					,ISNULL(CONVERT(DECIMAL(38,2),(TempCouponDetails.[Redemptions] * [AmountOff])),0) AS [CostAssociated]
					,TempCampaignDetails.IsActive
					,TempCampaignAttributes.EffectiveStartDateTime
					,TempCampaignAttributes.EffectiveEndDateTime 
					,TempCampaignAttributes.MaxRedemption
					,TempCampaignAttributes.LapsePeriod	
			FROM
				(
				SELECT	C.CampaignID
						,C.UTCCreatedDateTime
						,CampaignCode
						,C.CampaignTypeID
						,CTM.CampaignTypeName
						,C.DescriptionShort
						,C.DescriptionLong
						,C.Amount AS [AmountOff]
						,C.IsActive												
				 FROM Coupon.Campaign C (NOLOCK)
				INNER JOIN Coupon.CampaignTypeMaster CTM (NOLOCK)
					ON C.CampaignTypeID = CTM.CampaignTypeID		
				)TempCampaignDetails
				LEFT OUTER JOIN (SELECT	Cpn.CampaignID
										,Sum (Cpn.RedeemCount) AS [Redemptions]								
								FROM Coupon.Coupon Cpn						
								GROUP BY CampaignID
								)TempCouponDetails
				ON TempCampaignDetails.CampaignID = TempCouponDetails.CampaignID
				INNER JOIN TempCampaignAttributes --Only those records will come for which campaign attributes exists
					ON TempCampaignAttributes.CampaignID=TempCampaignDetails.CampaignID				
				)TempT
			)Temp
			WHERE RowNumber BETWEEN (@Start+1) AND (@Start+@PageSize)
			ORDER BY RowNumber
			
			
		END TRY

		BEGIN CATCH
				SET @ErrorMessage = ERROR_MESSAGE()	
		
				RAISERROR (
				'SP - [Coupon].[CampaignDetailsGetPage] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
		END CATCH;
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsGetPage] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetPage] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetPage] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage1]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CampaignDetailsGetPage1]
    
    IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage1]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetPage1] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CampaignDetailsGetPage1] not dropped.',
            16,
            1
        )
    END
END

GO
CREATE PROCEDURE [Coupon].[CampaignDetailsGetPage1] 
(
	 @StartDate DATETIME
	,@EndDate   DATETIME
	,@CampaignCode NVARCHAR(25)
	,@CampaignDiscription NVARCHAR(200)
	,@SubscriptionPlan NVARCHAR(50)
	,@Filtervalue INT
	,@PageOffset INT
	,@PageSize INT
)
AS
/*

	Author:			Deepmala
	Date created:	22/02/2013
	Purpose:		Returns All Coupon Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		BOA
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
   
*/
BEGIN
SET NOCOUNT ON
	

DECLARE 
    @CurrentDate DATETIME 
   ,@ErrorMessage  NVARCHAR(2048)
   ,@PlanData VARCHAR(100)
   ,@PageStart INT
   ,@PageEnd INT

SELECT @CurrentDate  = CONVERT(VARCHAR(10),GETDATE(),101)
      ,@PageStart = (@PageSize * (@PageOffset - 1)) + 1
      ,@PageEnd = (@PageOffset * @PageSize)

BEGIN TRY
	CREATE TABLE #TmpSearchData(CampaignId BIGINT,EffectiveStartDateTime DATETIME,EffectiveEndDateTime DATETIME,
				CouponsGeneratedCount VARCHAR(100),UTCCreatedDateTime DATETIME,CampaignCode VARCHAR(50),
				InternalDescription VARCHAR(300), CampaignTypeName VARCHAR(100), UsageName VARCHAR(100),IsActive BIT,
				Redemptions INT, AmountDiscount NUMERIC(10,2),PercentageDiscount INT ,CCDiscount INT,CostAssociated VARCHAR(100))
	
	CREATE TABLE #FinalData(CampaignId BIGINT,EffectiveStartDateTime DATETIME,EffectiveEndDateTime DATETIME,
				CouponsGeneratedCount VARCHAR(100),UTCCreatedDateTime DATETIME,CampaignCode VARCHAR(50),
				InternalDescription VARCHAR(300), CampaignTypeName VARCHAR(100), UsageName VARCHAR(100),IsActive BIT,
				Redemptions INT, AmountDiscount NUMERIC(10,2),PercentageDiscount INT,CCDiscount INT,
				CostAssociated VARCHAR(100), RNo INT)
			
	CREATE TABLE #CC (CampaignId BIGINT)--Hold the campaignids after filter on CampaignCode or CouponCode 
	CREATE TABLE #PlanTable (PlanId NVARCHAR(25))

		IF(LEN(@SubscriptionPlan)>0)
		BEGIN
			INSERT INTO #PlanTable ([PlanId]) SELECT Item FROM dbo.ConvertListToTable(@SubscriptionPlan,',')
		END

		IF (len(IsNull(@CampaignCode,''))>5)
		BEGIN
			INSERT INTO #CC SELECT CC.CampaignId FROM coupon.campaign CC					
			JOIN Coupon.Coupon CO ON CO.CampaignId = CC.CampaignId WHERE (CouponCode like '%'+ @CampaignCode + '%') 					
		END
		ELSE 

		BEGIN
			INSERT INTO #CC SELECT CC.CampaignId FROM coupon.campaign CC								
			WHERE (CampaignCode like '%'+ @CampaignCode + '%' OR @CampaignCode IS NULL) 					
		END

		;WITH TempCampaignAttributes AS
		( SELECT PVT.CampaignId,CONVERT(DATETIME,PVT.[2],101) EffectiveStartDateTime
				,CONVERT(DATETIME,PVT.[3],101) EffectiveEndDateTime	,CONVERT(INT,PVT.[6]) CouponsGeneratedCount
				,PVT.UTCCreatedDateTime,PVT.CampaignCode,PVT.InternalDescription,PVT.CampaignTypeName,PVT.UsageName,
				PVT.IsActive
			FROM
				(
					Select CC.CampaignId,CC.UTCCreatedDateTime ,CampaignCode,CC.DescriptionShort as InternalDescription,CampaignTypeName,
					UsageName,CC.IsActive, AttributeValue,AttributeId			
					From coupon.campaign CC					
					INNER JOIN Coupon.CampaignTypeMaster CT ON CC.CampaignTypeId = CT.CampaignTypeId
					INNER JOIN Coupon.CouponUsageType CU ON CC.UsageTypeId = CU.UsageTypeId
					INNER JOIN Coupon.CampaignAttributes CA ON ca.CampaignID = Cc.CampaignID	
					INNER JOIN #CC ON #CC.CampaignId = CC.CampaignId 				
					WHERE 						
					((CC.DescriptionShort like '%'+ @CampaignDiscription + '%' OR @CampaignDiscription IS NULL) 
					OR (CC.DescriptionLong like '%'+ @CampaignDiscription + '%' OR @CampaignDiscription IS NULL))				
				) A
					PIVOT (MIN(Attributevalue) FOR AttributeID in ([2],[3],[6])
				) PVT 			
		)

		Select * INTO #Mydata From TempCampaignAttributes
		
		--select * from #Mydata
		SELECT	CPN.CampaignID ,SUM (Cpn.RedeemCount) AS [Redemptions] INTO #RemData
        FROM Coupon.Coupon Cpn		
		JOIN #Mydata ON #Mydata.CampaignId = CPN.CampaignID				
        GROUP BY CPN.CampaignID 
		
		--Discounts calculation (Value column in UI)
		SELECT [1] AS AmountDiscount,[2] AS PercentageDiscount,[3]AS CCDiscount,CampaignId INTO #DiscountsData
		From 
			(
				SELECT DiscountTypeId,DiscountValue,CD.CampaignId FROM Coupon.CampaignDiscountType CD
				JOIN #Mydata ON #Mydata.CampaignId = CD.CampaignID	
			)A
			PIVOT(MIN(DiscountValue) FOR DiscountTypeId in ([1],[2],[3])
		)B
		--select * from #DiscountsData

		--Cost Associated  : Start
		SELECT CO.campaignid,CAST(SUM(PaymentAmount) AS NUMERIC(10,2)) AS CostAssociated INTO #TmpAmtData
		FROM tescosubscription.customerpaymenthistory CPH
		JOIN tescosubscription.customerpaymenthistoryresponse CPHR
        ON CPH.CustomerPaymentHistoryId = CPHR.CustomerPaymentHistoryId		
		JOIN tescosubscription.customerpayment CP 
        ON CP.CustomerPaymentId = CPH.CustomerPaymentId
		JOIN coupon.coupon CO 
        ON CO.CouponCode = CP.PaymentToken
		JOIN #Mydata 
        ON #Mydata.CampaignId = CO.CampaignID	
		WHERE paymentmodeid = 2
        AND PaymentStatusId = 1
		GROUP BY CO.campaignid

		SELECT CO.campaignid,COUNT(DISTINCT CustomerSubscriptionid) AS CSCount INTO #TmpCCData 
		FROM tescosubscription.customerpaymenthistory CPH
		JOIN tescosubscription.customerpaymenthistoryresponse CPHR
        ON CPH.CustomerPaymentHistoryId = CPHR.CustomerPaymentHistoryId
		JOIN tescosubscription.customerpayment CP 
        ON CP.CustomerPaymentId = CPH.CustomerPaymentId
		JOIN coupon.coupon CO 
        ON CO.CouponCode = CP.PaymentToken
		JOIN coupon.campaignDIscountType CDT 
        ON CDT.CampaignId = CO.CampaignId
		JOIN #Mydata 
        ON #Mydata.CampaignId = CO.CampaignID	
		WHERE paymentmodeid = 2 AND PaymentStatusId = 1 AND CDT.DiscountTypeId = 3
		GROUP BY CO.campaignid,CustomerSubscriptionid

		SELECT TC.CampaignId,CAST(SUM(CSCount * DiscountValue) AS INT) AS CCPointsDiscount 
		INTO #TmpFInalCcData FROM #TmpCCData TC 
		JOIN coupon.campaignDIscountType CD
        ON CD.CampaignId = TC.CampaignId 
		WHERE discounttypeid = 3
		GROUP BY TC.CampaignId
		
		SELECT #TmpAmtData.CampaignId,
			(CASE WHEN ISNULL(CostAssociated,0)>0 then ('œ' + CONVERT(VARCHAR,CostAssociated)) ELSE '' END) + 
			(CASE WHEN (ISNULL(CostAssociated,0)>0 and isnull(CCPointsDiscount,0)>0) THEN ', ' ELSE '' END) + 
			(CASE WHEN ISNULL(CCPointsDiscount,0)>0 THEN (CONVERT(VARCHAR,CCPointsDiscount) + ' CC POINTS') ELSE '' END 
			
			)
			AS CostAssociated			
		INTO #TmpFinalCostData
		FROM #TmpAmtData
		LEFT join #TmpFInalCcData on #TmpAmtData.Campaignid = #TmpFInalCcData.campaignid
		--Calculation end
		
		;WITH CampaignSearch AS (SELECT MyData.CampaignId,MyData.EffectiveStartDateTime,MyData.EffectiveEndDateTime				
				,MyData.CouponsGeneratedCount,MyData.UTCCreatedDateTime,MyData.CampaignCode,MyData.InternalDescription,
				MyData.CampaignTypeName,MyData.UsageName,MyData.IsActive
				,#RemData.Redemptions,AmountDiscount,PercentageDiscount,CCDiscount,#TmpFinalCostData.CostAssociated				
				FROM  #Mydata MyData
				INNER JOIN #RemData ON #RemData.CampaignId = Mydata.CampaignId
				INNER JOIN #DiscountsData ON #DiscountsData.CampaignId = Mydata.CampaignId
				LEFT OUTER JOIN #TmpFinalCostData ON #TmpFinalCostData.CampaignId = Mydata.CampaignId
					)
			
		SELECT * INTO #Mydata1 FROM CampaignSearch 
		--select * from #Mydata1
		IF ((Select count(*) from #PlanTable)>0)
		BEGIN	
			--Filter unique campaignids for plan search to avoid multiple records for one campaign with multiple plans
			SELECT distinct TC.CampaignId INTO #CampaignsPlan FROM #Mydata1 TC
			JOIN Coupon.CampaignPlanDetails CP ON CP.CampaignId = TC.CampaignId
			JOIN #PlanTable P ON P.PlanId = CP.SubscriptionPlanId
			
			INSERT INTO #TmpSearchData (CampaignId,EffectiveStartDateTime,EffectiveEndDateTime,
				CouponsGeneratedCount,UTCCreatedDateTime,CampaignCode,
				InternalDescription, CampaignTypeName ,UsageName,IsActive,
				Redemptions, AmountDiscount,PercentageDiscount,CCDiscount,CostAssociated)
			SELECT TC.CampaignId,EffectiveStartDateTime,EffectiveEndDateTime,CouponsGeneratedCount,
				TC.UTCCreatedDateTime,CampaignCode,InternalDescription,CampaignTypeName,UsageName,IsActive,Redemptions,
				AmountDiscount,PercentageDiscount,CCDiscount,CostAssociated
			FROM #Mydata1 TC
			JOIN #CampaignsPlan CP ON CP.CampaignId = TC.CampaignId
			
		END

		ELSE

		BEGIN
			INSERT INTO #TmpSearchData SELECT * FROM #Mydata1
		END		
		
		If ISNULL(@Filtervalue,0) = 1 --Active Campaign
		Begin
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber FROM #TmpSearchData
				WHERE CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(VARCHAR,GETDATE(),101) and
				CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(VARCHAR,GETDATE(),101) and IsActive = 1
				AND (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL)
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101) OR @StartDate IS NULL)
			)

			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		End
		Else If ISNULL(@Filtervalue,0) = 2 --Future Campaign
		Begin
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber FROM #TmpSearchData
				WHERE CONVERT(DATETIME,EffectiveStartDateTime,101) > CONVERT(VARCHAR,GETDATE(),101) and IsActive = 1
				AND (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL)
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101) OR @StartDate IS NULL)
			)
						
			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		End
		Else If ISNULL(@Filtervalue,0) = 3  --Past Campaign
		Begin
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber
				 FROM #TmpSearchData
				Where CONVERT(DATETIME,EffectiveEndDateTime,101) < CONVERT(VARCHAR,GETDATE(),101) --and IsActive = 0
				AND (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL)
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101) OR @StartDate IS NULL)
			)
						
			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		End
		Else If ISNULL(@Filtervalue,0) = 4 --Stopped Campaign
		Begin
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber FROM #TmpSearchData Where IsActive = 0
				AND (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL) 
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101)OR @StartDate IS NULL)
				)		
			
			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		END
		ELSE
		BEGIN	
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber FROM #TmpSearchData
				WHERE (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL) 
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101)OR @StartDate IS NULL)
			)
			
			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		END

		SELECT * FROM #FinalData WHERE RNo BETWEEN @PageStart and @PageEnd
		SELECT COUNT(CampaignId) as TotalRecords FROM #FinalData
END TRY

BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()	

		RAISERROR (
		'SP - [Coupon].[CampaignDetailsGetPage1] Error = (%s)',
		16,
		1,
		@ErrorMessage
		)
END CATCH;

END
 
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsGetPage1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage1]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetPage1] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CampaignDetailsGetPage1] not created.',
        16,
        1
    )
END
GO



 
 



USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsSave]

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsSave] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignDetailsSave]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignDetailsSave]
** DATE WRITTEN   : 25/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignDetailsSave] 
(
@XmlDocument XML
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @XmlDocumentHandle		INT
	DECLARE @NewCampaignId			BIGINT	
	DECLARE @SaveIdnFlag			VARCHAR(50)
	DECLARE @ProcSection			VARCHAR(100)
	DECLARE @CampaignTypeID			INT 

	BEGIN TRY

	SET @ProcSection = 'Section Reading XML'
	-- Create an internal representation of the XML document.
	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @XmlDocument


	SELECT CampaignID
			,CampaignCode
			,DescriptionShort
			,DescriptionLong
			,Amount
			,CASE WHEN IsActive like 'true'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignTypeId
			,GetUTCDate() AS UTCCreatedeDateTime
			,GetUTCDate() AS UTCUpdatedDateTime
	INTO #TempCampaignDetails		
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, '/Campaign',1)
		WITH (	CampaignID			BIGINT,				--check on this
				CampaignCode		NVARCHAR(25),
				DescriptionShort	NVARCHAR(200),
				DescriptionLong		NVARCHAR(300),
				Amount				MONEY,
				IsActive			VARCHAR(5),
				CampaignTypeId int
			  )
		  )TempCampaign
		  
	IF EXISTS (SELECT 1 FROM #TempCampaignDetails WHERE LEN(CampaignCode) = 0)
	BEGIN
		SET @ErrorMessage = 'Invalid Coupon Code is being transmitted. Please check.'
		
		RAISERROR (
				'%s',
				16,
				1,
				@ErrorMessage
			)
	END
	
	SELECT @CampaignTypeId = CampaignTypeId FROM  #TempCampaignDetails
	
	IF (@CampaignTypeId = 3) --Linked Coupon(s) need to be generated
		BEGIN
			SELECT CustomerID
					,CouponCode
					--,DescriptionShort
					--,DescriptionLong
					,Amount
					,RedeemCount
					,CASE WHEN IsActive like 'True'
						THEN 1
						ELSE
						0
					END AS IsActive
					,CampaignID
					,GetUTCDate() AS UTCCreatedeDateTime
					,GetUTCDate() AS UTCUpdatedDateTime
			INTO #TempLinkedCouponDetails
			FROM(
			SELECT *
			FROM OPENXML (@XmlDocumentHandle, '/Campaign/CouponsList/CouponDetail',1)
			WITH (	CustomerID			bigint,
					CouponCode			nvarchar(25),
					--DescriptionShort	nvarchar(200),
					--DescriptionLong		nvarchar(300),
					Amount				Money,
					RedeemCount			int,
					IsActive			varchar(5),
					CampaignID			bigint
				  )
				  )TempCoupon
		END
	ELSE
		BEGIN	     
			--Coupons Details 
			SELECT  CouponCode
					--,DescriptionShort
					--,DescriptionLong
					,Amount
					,RedeemCount
					,CASE WHEN IsActive like 'True'
						THEN 1
						ELSE
						0
					END AS IsActive
					,CampaignID
					,GetUTCDate() AS UTCCreatedeDateTime
					,GetUTCDate() AS UTCUpdatedDateTime
			INTO #TempCouponDetails
			FROM(
				SELECT *
				FROM OPENXML (@XmlDocumentHandle, '/Campaign/CouponsList/CouponDetail',1)
				WITH (	CouponCode			NVARCHAR(25),
						--DescriptionShort	NVARCHAR(200),
						--DescriptionLong		NVARCHAR(300),
						Amount				MONEY,
						RedeemCount			INT,
						IsActive			VARCHAR(5),
						CampaignID			BIGINT
					  )
				  )TempCoupon
		END     

	--Attribute Details 
	SELECT TempAttributes.*
			,GETUTCDATE() AS [UTCCreatedDateTime]
			,GETUTCDATE() AS [UTCUpdatedDateTime]
	INTO #TempCampaignAttributes
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignAttributesList/CampaignAttribute',3)
		WITH (AttributeID		SMALLINT,
			  AttributeValue	NVARCHAR(50)
			  )
		)TempAttributes
	ORDER BY TempAttributes.AttributeId 

	EXEC sp_xml_removedocument @XmlDocumentHandle

	END TRY

	BEGIN CATCH
		SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
		
		RAISERROR (
				'SP - [coupon].[CampaignDetailsSave] Error = (%s)',
				16,
				1,
				@ErrorMessage
			)
	END CATCH


	BEGIN TRY
	
	BEGIN TRANSACTION [Save_CampaignDetails] 

	IF (@CampaignTypeId >=1 AND @CampaignTypeId <=3) --Saving Campaign Details and Naive or Unique Coupon(s)
	BEGIN
			SET @ProcSection = 'Section in Coupon.Campaign:'
			
			INSERT INTO [TescoSubscription].[Coupon].[Campaign]
					   ([CampaignCode]
					   ,[DescriptionShort]
					   ,[DescriptionLong]
					   ,[Amount]
					   ,[IsActive]
					   ,[CampaignTypeId]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
				SELECT CampaignCode
						,DescriptionShort
						,DescriptionLong
						,Amount
						,IsActive
						,CampaignTypeId
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
				FROM #TempCampaignDetails		
				
			SELECT @NewCampaignId = @@IDENTITY
					
			PRINT 'New CampaignID Generated: ' + Convert(Varchar(200),@NewCampaignId) --remove this line in final code of proc
			
			SET @ProcSection = 'Section in Coupon.Coupon: '
			
			IF (@CampaignTypeId >=1 AND @CampaignTypeId <=2)
			BEGIN
			--PRINT 'INSERTING NAIVE OR UNIQUE COUPONS'
			INSERT INTO [TescoSubscription].[Coupon].[Coupon]
					   ([CouponCode]
					   --,[DescriptionShort]
					   --,[DescriptionLong]
					   ,[Amount]
					   ,[RedeemCount]
					   ,[IsActive]
					   ,[UTCCreatedeDateTime]
					   ,[UTCUpdatedDateTime]
					   ,[CampaignID])
				SELECT CouponCode
						--,DescriptionShort
						--,DescriptionLong
						,Amount
						,RedeemCount
						,IsActive					
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
						,@NewCampaignId
				FROM #TempCouponDetails
			END
			
			IF (@CampaignTypeId = 3) --Customer Linked Coupons
			BEGIN
				--PRINT 'INSERTING LINKED COUPONS'
				INSERT INTO [TescoSubscription].[Coupon].[Coupon]
					   ([CouponCode]
					   --,[DescriptionShort]
					   --,[DescriptionLong]
					   ,[Amount]
					   ,[RedeemCount]
					   ,[IsActive]
					   ,[UTCCreatedeDateTime]
					   ,[UTCUpdatedDateTime]
					   ,[CampaignID])
				SELECT CouponCode
						--,DescriptionShort
						--,DescriptionLong
						,Amount
						,RedeemCount
						,IsActive					
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
						,@NewCampaignId
				FROM #TempLinkedCouponDetails
			END
				
			SET @ProcSection = 'Section Coupon.CampaignAttributes: '
							
			INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
					   ([CampaignID]
					   ,[AttributeID]
					   ,[AttributeValue]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
				SELECT @NewCampaignId
						,AttributeID
						,AttributeValue
						,UTCCreatedDateTime
						,UTCUpdatedDateTime
				FROM #TempCampaignAttributes		
				
				
		END
			
	IF (@CampaignTypeId = 3)
		BEGIN		
			SET @ProcSection = 'Section Coupon.CouponCustomerMap: '
				
			INSERT INTO [TescoSubscription].[Coupon].[CouponCustomerMap]
			   ([CouponID]
			   ,[CustomerID]
			   ,[UTCCreatedDateTime]
			   ,[UTCUpdatedDateTime])
			Select Cpn.CouponID
				,Tcd.CustomerID
				,GetUTCDate() AS [UTCCreatedDateTime]
				,GetUTCDate() AS [UTCUpdatedDateTime]
			FROM #TempLinkedCouponDetails Tcd
			INNER JOIN Coupon.Coupon Cpn
				ON Lower(Tcd.CouponCode) = Lower(Cpn.CouponCode)					
		END
		
	IF (@CampaignTypeId < 1 OR @CampaignTypeId > 3)
		BEGIN
			SET @ErrorMessage = 'Unrecognised CampaignType supplied in XML '
			
			IF @@TRANCOUNT > 0
					BEGIN
						ROLLBACK TRANSACTION [Save_CampaignDetails]
					END
			
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
		
		COMMIT TRANSACTION [Save_CampaignDetails]		
				
	--Removing Temporary Table(S)
	
	DROP TABLE #TempCampaignDetails
	
	IF (@CampaignTypeId <> 3)
	BEGIN
		DROP TABLE #TempCouponDetails
	END
	ELSE
	BEGIN
		DROP TABLE #TempLinkedCouponDetails
	END
	
	DROP TABLE #TempCampaignAttributes

	--Selecting the new Campaign ID generated in String Format as per UI req.
	SELECT CONVERT(VARCHAR(100),@NewCampaignId)				
	PRINT 'CAMPAIGN AND COUPON(S) SUCCESSFULLY SAVED IN DATABASE.'		
		
	END TRY	
	BEGIN CATCH
			SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
	
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [Save_CampaignDetails]
			END
			
			RAISERROR (
					'SP - [coupon].[CampaignDetailsSave] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)
	END CATCH

END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsSave] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsSave1]

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsSave1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsSave1] not dropped.',16,1)
			END
	END
GO
CREATE PROCEDURE [Coupon].[CampaignDetailsSave1] 
(
@XmlDocument XML
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @XmlDocumentHandle		INT
	DECLARE @NewCampaignId			BIGINT	
	DECLARE @SaveIdnFlag			VARCHAR(50)
	DECLARE @ProcSection			VARCHAR(100)
	DECLARE @CampaignTypeID			INT 
	DECLARE @UsageType				INT

	BEGIN TRY

	SET @ProcSection = 'Section Reading XML'
	-- Create an internal representation of the XML document.
	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @XmlDocument


	SELECT CampaignID
			,CampaignCode
			,DescriptionShort
			,DescriptionLong
			,Amount
			,CASE WHEN IsActive like 'true'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignTypeId
			,IsMutuallyExclusive
			,UsageTypeID
			,GetUTCDate() AS UTCCreatedeDateTime
			,GetUTCDate() AS UTCUpdatedDateTime
	INTO #TempCampaignDetails		
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign',2)
		WITH (	CampaignID			BIGINT,				--check on this
				CampaignCode		NVARCHAR(25),
				DescriptionShort	NVARCHAR(200),
				DescriptionLong		NVARCHAR(300),
				Amount				MONEY,
				IsActive			VARCHAR(5),
				CampaignTypeId		INT,
				IsMutuallyExclusive	BIT,
				UsageTypeId         TINYINT './UsageType/UsageTypeId'
			  )
		  )TempCampaign
		  
	IF EXISTS (SELECT 1 FROM #TempCampaignDetails WHERE LEN(CampaignCode) = 0)
	BEGIN
		SET @ErrorMessage = 'Invalid Coupon Code is being transmitted. Please check.'
		
		RAISERROR (
				'%s',
				16,
				1,
				@ErrorMessage
			)
	END
	
 --Adding PlanIDs to temp table
	SELECT 
			*
	INTO #TempPlanID		
	FROM (			
		SELECT *
FROM   OPENXML(@XmlDocumentHandle, 'Campaign/SubscriptionPlanIds/string', 2)
       WITH ([PlanID] INT '.')
		  )TempPlans

 --Adding Discount types
SELECT 
			*
	INTO #TempDiscountTypes
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignDiscounts/DiscountType',2)
		WITH (	DiscountTypeId			TINYINT,
				DiscountTypeValue       DECIMAL(6,2)				--check on this
			  )
		  )TempDiscounts


	SELECT @CampaignTypeId = CampaignTypeId FROM  #TempCampaignDetails
	
	IF (@CampaignTypeId = 3) --Linked Coupon(s) need to be generated
		BEGIN
			SELECT CustomerID
					,CouponCode
					--,DescriptionShort
					--,DescriptionLong
					,Amount
					,RedeemCount
					,CASE WHEN IsActive like 'True'
						THEN 1
						ELSE
						0
					END AS IsActive
					,CampaignID
					,GetUTCDate() AS UTCCreatedeDateTime
					,GetUTCDate() AS UTCUpdatedDateTime
			INTO #TempLinkedCouponDetails
			FROM(
			SELECT *
			FROM OPENXML (@XmlDocumentHandle, 'Campaign/Coupons/Coupon',2)
			WITH (	CustomerID			bigint 'CustomerIds/string',
					CouponCode			nvarchar(25) './CouponCode',
					--DescriptionShort	nvarchar(200),
					--DescriptionLong		nvarchar(300),
					Amount				Money,
					RedeemCount			int,
					IsActive			varchar(5),
					CampaignID			bigint
				  )
				  )TempCoupon
		END
	ELSE
		BEGIN	     
			--Coupons Details 
			SELECT  CouponCode
					--,DescriptionShort
					--,DescriptionLong
					,Amount
					,RedeemCount
					,CASE WHEN IsActive like 'True'
						THEN 1
						ELSE
						0
					END AS IsActive
					,CampaignID
					,GetUTCDate() AS UTCCreatedeDateTime
					,GetUTCDate() AS UTCUpdatedDateTime
			INTO #TempCouponDetails
			FROM(
				SELECT *
				FROM OPENXML (@XmlDocumentHandle, 'Campaign/Coupons/Coupon',2)
				WITH (	CouponCode			NVARCHAR(25),
						--DescriptionShort	NVARCHAR(200),
						--DescriptionLong		NVARCHAR(300),
						Amount				MONEY,
						RedeemCount			INT,
						IsActive			VARCHAR(5),
						CampaignID			BIGINT
					  )
				  )TempCoupon
		END     

	--Attribute Details 
	SELECT TempAttributes.*
			,GETUTCDATE() AS [UTCCreatedDateTime]
			,GETUTCDATE() AS [UTCUpdatedDateTime]
	INTO #TempCampaignAttributes
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignAttributes/CampaignAttribute',3)
		WITH (AttributeID		SMALLINT,
			  AttributeValue	NVARCHAR(50)
			  ) where AttributeID > 0
		)TempAttributes
	ORDER BY TempAttributes.AttributeId 

	EXEC sp_xml_removedocument @XmlDocumentHandle

	END TRY

	BEGIN CATCH
		SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
		
		RAISERROR (
				'SP - [coupon].[CampaignDetailsSave] Error = (%s)',
				16,
				1,
				@ErrorMessage
			)
	END CATCH


	BEGIN TRY
	
	BEGIN TRANSACTION [Save_CampaignDetails] 

	IF (@CampaignTypeId >=1 AND @CampaignTypeId <=3) --Saving Campaign Details and Naive or Unique Coupon(s)
	BEGIN
			SET @ProcSection = 'Section in Coupon.Campaign:'
			
			INSERT INTO [TescoSubscription].[Coupon].[Campaign]
					   ([CampaignCode]
					   ,[DescriptionShort]
					   ,[DescriptionLong]
					   ,[Amount]
					   ,[IsActive]
					   ,[CampaignTypeId]
					   ,IsMutuallyExclusive	
					   ,UsageTypeID	
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
				SELECT CampaignCode
						,DescriptionShort
						,DescriptionLong
						,0
						,IsActive
						,CampaignTypeId
						,IsMutuallyExclusive	
					    ,UsageTypeId	
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
				FROM #TempCampaignDetails		
				
			SELECT @NewCampaignId = @@IDENTITY
					
			--PRINT 'New CampaignID Generated: ' + Convert(Varchar(200),@NewCampaignId) --remove this line in final code of proc
			
			SET @ProcSection = 'Section in Coupon.Coupon: '
			
			IF (@CampaignTypeId >=1 AND @CampaignTypeId <=2)
			BEGIN
			--PRINT 'INSERTING NAIVE OR UNIQUE COUPONS'
			INSERT INTO [TescoSubscription].[Coupon].[Coupon]
					   ([CouponCode]
					   --,[DescriptionShort]
					   --,[DescriptionLong]
					   ,[Amount]
					   ,[RedeemCount]
					   ,[IsActive]
					   ,[UTCCreatedeDateTime]
					   ,[UTCUpdatedDateTime]
					   ,[CampaignID])
				SELECT CouponCode
						--,DescriptionShort
						--,DescriptionLong
						,0
						,RedeemCount
						,IsActive					
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
						,@NewCampaignId
				FROM #TempCouponDetails
			END
			
			IF (@CampaignTypeId = 3) --Customer Linked Coupons
			BEGIN
				--PRINT 'INSERTING LINKED COUPONS'
				INSERT INTO [TescoSubscription].[Coupon].[Coupon]
					   ([CouponCode]
					   --,[DescriptionShort]
					   --,[DescriptionLong]
					   ,[Amount]
					   ,[RedeemCount]
					   ,[IsActive]
					   ,[UTCCreatedeDateTime]
					   ,[UTCUpdatedDateTime]
					   ,[CampaignID])
				SELECT CouponCode
						--,DescriptionShort
						--,DescriptionLong
						,0
						,RedeemCount
						,IsActive					
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
						,@NewCampaignId
				FROM #TempLinkedCouponDetails
			END
				
			SET @ProcSection = 'Section Coupon.CampaignAttributes: '
							
			INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
					   ([CampaignID]
					   ,[AttributeID]
					   ,[AttributeValue]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
				SELECT @NewCampaignId
						,AttributeID
						,AttributeValue
						,UTCCreatedDateTime
						,UTCUpdatedDateTime
				FROM #TempCampaignAttributes		
				
				
		END
			
	IF (@CampaignTypeId = 3)
		BEGIN		
			SET @ProcSection = 'Section Coupon.CouponCustomerMap: '
				
			INSERT INTO [TescoSubscription].[Coupon].[CouponCustomerMap]
			   ([CouponID]
			   ,[CustomerID]
			   ,[UTCCreatedDateTime]
			   ,[UTCUpdatedDateTime])
			Select Cpn.CouponID
				,Tcd.CustomerID
				,GetUTCDate() AS [UTCCreatedDateTime]
				,GetUTCDate() AS [UTCUpdatedDateTime]
			FROM #TempLinkedCouponDetails Tcd
			INNER JOIN Coupon.Coupon Cpn
				ON Lower(Tcd.CouponCode) = Lower(Cpn.CouponCode)					
		END
		
      INSERT INTO Coupon.CampaignDiscountType
		(CampaignID
		,DiscountTypeID
		,DiscountValue
		,[UTCCreatedDateTime]
		,[UTCUpdatedDateTime])
		
		Select 
		@NewCampaignId
		,DiscountTypeId
		,DiscountTypeValue
		,GetUTCDate() AS [UTCCreatedDateTime]
		,GetUTCDate() AS [UTCUpdatedDateTime]
		 FROM #TempDiscountTypes 
		
	INSERT INTO Coupon.CampaignPlanDetails
		(CampaignID
		 ,SubscriptionPlanID
		 ,UTCCreatedDateTime
		 ,UTCUpdatedDateTime)
		SELECT 
		  @NewCampaignId
		 ,PlanID
		 ,GetUTCDate() AS [UTCCreatedDateTime]
		 ,GetUTCDate() AS [UTCUpdatedDateTime]
         FROM #TempPlanID

	IF (@CampaignTypeId < 1 OR @CampaignTypeId > 3)
		BEGIN
			SET @ErrorMessage = 'Unrecognised CampaignType supplied in XML '
			
			IF @@TRANCOUNT > 0
					BEGIN
						ROLLBACK TRANSACTION [Save_CampaignDetails]
					END
			
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
		
		COMMIT TRANSACTION [Save_CampaignDetails]		
				
	--Removing Temporary Table(S)
	
	DROP TABLE #TempCampaignDetails
	
	IF (@CampaignTypeId <> 3)
	BEGIN
		DROP TABLE #TempCouponDetails
	END
	ELSE
	BEGIN
		DROP TABLE #TempLinkedCouponDetails
	END
	
	DROP TABLE #TempCampaignAttributes
	DROP TABLE #TempDiscountTypes
	DROP TABLE #TempPlanID
	--Selecting the new Campaign ID generated in String Format as per UI req.
	SELECT CONVERT(VARCHAR(100),@NewCampaignId)				
	PRINT 'CAMPAIGN AND COUPON(S) SUCCESSFULLY SAVED IN DATABASE.'		
		
	END TRY	
	BEGIN CATCH
			SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
	
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [Save_CampaignDetails]
			END
			
			RAISERROR (
					'SP - [coupon].[CampaignDetailsSave1] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)
	END CATCH

END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsSave1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsSave1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsSave1] not created.',16,1)
	END
GO






USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignEdit]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignEdit]

		IF OBJECT_ID(N'[Coupon].[CampaignEdit]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignEdit] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignEdit]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignEdit]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignEdit] 
(
@XmlDocument XML
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @XmlDocumentHandle		INT
	DECLARE @CampaignID				BIGINT
	DECLARE @RecordsToAdd			BIGINT
	DECLARE @RecordsToDelete		BIGINT
	DECLARE @RecordsToDeleteCoup	BIGINT
	DECLARE @ProcSection			VARCHAR(100)
	DECLARE @CampaignTypeID			INT
	

	BEGIN TRY

	SET @ProcSection = 'Section Reading XML'
	-- Create an internal representation of the XML document.
	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @XmlDocument


	SELECT CampaignID
			,CampaignCode
			,DescriptionShort
			,DescriptionLong
			,Amount
			,CASE WHEN IsActive like 'true'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignTypeId
			,GetUTCDate() AS UTCUpdatedDateTime
	INTO #TempCampaignDetails		
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, '/Campaign',1)
		WITH (	CampaignID			BIGINT,				--check on this
				CampaignCode		NVARCHAR(25),
				DescriptionShort	NVARCHAR(200),
				DescriptionLong		NVARCHAR(300),
				Amount				MONEY,
				IsActive			VARCHAR(5),
				CampaignTypeId int
			  )
		  )TempCampaign
		  
	IF EXISTS (SELECT 1 FROM #TempCampaignDetails WHERE LEN(CampaignCode) = 0)
	BEGIN
		SET @ErrorMessage = 'Invalid Coupon Code is being transmitted. Please check.'
		
		RAISERROR (
				'%s',
				16,
				1,
				@ErrorMessage
			)
	END
	
	SELECT @CampaignID = CampaignID,
			@CampaignTypeId = CampaignTypeId 
	FROM  #TempCampaignDetails
	
	SELECT CustomerID
			,CouponCode
			,Amount
			,RedeemCount
			,CASE WHEN IsActive like 'True'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CASE WHEN IsRedeemed like 'True'
				THEN 1
				ELSE
				0
			END AS IsRedeemed
			,CampaignID
			,ActionFlag				
	INTO #TempLinkedCouponDetails
	FROM(
	SELECT *
	FROM OPENXML (@XmlDocumentHandle, '/Campaign/CouponsList/CouponDetail',1)
	WITH (	CustomerID			BIGINT,
			CouponCode			NVARCHAR(25),
			Amount				MONEY,
			RedeemCount			INT,
			IsActive			VARCHAR(5),
			IsRedeemed			VARCHAR(5),
			CampaignID			BIGINT,
			ActionFlag			VARCHAR(10)
		  )
		)TempCoupon
				  
	SELECT @RecordsToAdd = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 1 --Getting records to insert
	
	SELECT @RecordsToDelete = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 0 --Getting records to delete
	
	SELECT @RecordsToDeleteCoup = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 0 AND IsRedeemed = 0 -- Getting coupons to delete
	
	--Attribute Details 
	SELECT TempAttributes.*						
	INTO #TempCampaignAttributes
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignAttributesList/CampaignAttribute',3)
		WITH (AttributeID		SMALLINT,
			  AttributeValue	NVARCHAR(50)
			  )
		)TempAttributes
	ORDER BY TempAttributes.AttributeId 

	EXEC sp_xml_removedocument @XmlDocumentHandle


	BEGIN TRANSACTION [Save_CampaignDetails] 

	IF (@CampaignTypeId >=1 AND @CampaignTypeId <=3) --Editing Campaign Details for all Coupon(s)
	BEGIN
		
			SET @ProcSection = 'Update Section in Coupon.Campaign:'
				
			UPDATE [TescoSubscription].[Coupon].[Campaign]
					SET	CampaignCode = TCD.CampaignCode
						,DescriptionShort = TCD.DescriptionShort
						,DescriptionLong = TCD.DescriptionLong
						,Amount = TCD.Amount
						,IsActive = TCD.IsActive
						,CampaignTypeId = TCD.CampaignTypeId						
						,UTCUpdatedDateTime = GETUTCDATE()
					FROM #TempCampaignDetails TCD
					INNER JOIN [TescoSubscription].[Coupon].[Campaign] C
						ON C.CampaignID = TCD.CampaignID			
						
			IF(@@ROWCOUNT <> 1)
			BEGIN			
				SET @ErrorMessage = 'Failed in ' + @ProcSection
				
				RAISERROR (
							'%s',
							16,
							1,
							@ErrorMessage
							)
			END
			
			SET @ProcSection = 'Update Section Coupon.CampaignAttributes: '			
			
			UPDATE [TescoSubscription].[Coupon].[CampaignAttributes]
				SET	AttributeValue = TCA.AttributeValue,
					UTCUpdatedDateTime = GETUTCDATE()
				FROM #TempCampaignAttributes TCA
				INNER JOIN Coupon.CampaignAttributes CA
					   ON  CA.CampaignID = @CampaignID
					   AND CA.AttributeId = TCA.AttributeId	
					
			IF(@@ROWCOUNT <> 6)
			BEGIN			
				SET @ErrorMessage = 'Failed in ' + @ProcSection
				
				RAISERROR (
							'%s',
							16,
							1,
							@ErrorMessage
							)
			END		
			
				
			IF (@RecordsToAdd <> 0)
			BEGIN
			
			/*ADD SECTION BEGINS */
			
				SET @ProcSection = 'Add Section in Coupon.Coupon: '
					
					
					INSERT INTO [TescoSubscription].[Coupon].[Coupon]
						   ([CouponCode]
						   ,[Amount]
						   ,[RedeemCount]
						   ,[IsActive]
						   ,[UTCCreatedeDateTime]
						   ,[UTCUpdatedDateTime]
						   ,[CampaignID])
					SELECT CouponCode
							,Amount
							,RedeemCount
							,IsActive					
							,GetUTCDate() AS [UTCCreatedeDateTime]
							,GetUTCDate() AS [UTCUpdatedDateTime]
							,CampaignId
					FROM #TempLinkedCouponDetails TCD
					WHERE Tcd.IsActive = 1
						
					IF(@@ROWCOUNT <> @RecordsToAdd)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END		
				
					SET @ProcSection = 'Add Section Coupon.CouponCustomerMap: '
					
					INSERT INTO [TescoSubscription].[Coupon].[CouponCustomerMap]
					   ([CouponID]
					   ,[CustomerID]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
					Select Cpn.CouponID
							,Tcd.CustomerID
							,GetUTCDate() AS [UTCCreatedDateTime]
							,GetUTCDate() AS [UTCUpdatedDateTime]
					FROM #TempLinkedCouponDetails Tcd
					INNER JOIN Coupon.Coupon Cpn
						ON LOWER(Tcd.CouponCode) = LOWER(Cpn.CouponCode)
						AND Tcd.IsActive = 1
												
					IF(@@ROWCOUNT <> @RecordsToAdd)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END	
			END			
						
		/*ADD SECTION ENDS*/

		/*DELETE SECTION BEGINS*/			
			IF (@RecordsToDelete <> 0)
			BEGIN
				SET @ProcSection = 'Delete Section Coupon.CouponCustomerMap: '
				
				DELETE FROM [TescoSubscription].[Coupon].[CouponCustomerMap] 
				WHERE CouponID IN (
									SELECT Cpn.CouponID														
									FROM #TempLinkedCouponDetails Tcd
									INNER JOIN Coupon.Coupon Cpn
										ON Lower(Tcd.CouponCode) = Lower(Cpn.CouponCode)
										AND Tcd.IsActive = 0										
										)
					
				IF(@@ROWCOUNT <> @RecordsToDelete)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END	
					
				
				SET @ProcSection = 'Delete Section Coupon.Coupon: '					 
				
				DELETE FROM [TescoSubscription].[Coupon].[Coupon] 
				WHERE CouponCode IN (SELECT TCD.CouponCode 
										FROM #TempLinkedCouponDetails Tcd
											WHERE Tcd.IsActive = 0
											AND Tcd.IsRedeemed = 0
											)
					
					
				IF(@@ROWCOUNT <> @RecordsToDeleteCoup)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END				
					
			END		
		/*DELETE SECTION ENDS*/	
		
		COMMIT TRANSACTION [Save_CampaignDetails]
						
		END
	
		IF (@CampaignTypeId < 1 OR @CampaignTypeId > 3)
			BEGIN
				SET @ErrorMessage = 'Unrecognised CampaignType supplied in XML '
				
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION [Save_CampaignDetails]
				END
				
				RAISERROR (
						'%s',
						16,
						1,
						@ErrorMessage
						)
			END		
					
		--Removing Temporary Table(S)
		
		DROP TABLE #TempCampaignDetails
		
		DROP TABLE #TempLinkedCouponDetails
			
		DROP TABLE #TempCampaignAttributes
				
		PRINT 'CAMPAIGN AND COUPON(S) EDITED IN DATABASE FOR ' + CONVERT(NVARCHAR(100),@CampaignID) + ' CampaignID'
		
	END TRY	
	
	BEGIN CATCH
			SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
	
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [Save_CampaignDetails]
			END

			IF OBJECT_ID('tempdb..#TempCampaignDetails') IS NOT NULL DROP TABLE #TempCampaignDetails
			IF OBJECT_ID('tempdb..#TempLinkedCouponDetails') IS NOT NULL DROP TABLE #TempLinkedCouponDetails
			IF OBJECT_ID('tempdb..#TempCampaignAttributes') IS NOT NULL DROP TABLE #TempCampaignAttributes
						
			RAISERROR (
					'SP - [coupon].[CampaignEdit] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)
	END CATCH

END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignEdit] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignEdit]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignEdit] not created.',16,1)
	END
GOIF OBJECT_ID(N'[Coupon].[CampaignEdit1]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CampaignEdit1]
    
    IF OBJECT_ID(N'[Coupon].[CampaignEdit1]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit1] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CampaignEdit1] not dropped.',
            16,
            1
        )
    END
END

GO


CREATE PROCEDURE [Coupon].[CampaignEdit1] 
(
@XmlDocument XML
)
AS
/*   
 Author:   Saminathan
 Date created: 03 Apr 2014 
 Purpose:  Edits campaign Details
 Behaviour:  How does this procedure actually work  
 Usage:   Hourly/Often 
 Called by:  <SubscriptionService>  

  --Modifications History--  
 Changed On  Changed By  Defect Ref  Change Description  23/0
 
 */ 
BEGIN

	SET NOCOUNT ON

	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @XmlDocumentHandle		INT
	DECLARE @CampaignID				BIGINT
	DECLARE @RecordsToAdd			BIGINT
	DECLARE @RecordsToDelete		BIGINT
	--DECLARE @RecordsToDeleteCoup	BIGINT
	DECLARE @ProcSection			VARCHAR(100)
	DECLARE @CampaignTypeID			INT
	Declare @UsageTypeNew			INT
    Declare @UsageType			    INT
	Declare @ClubCardBoostFlagNew	BIT
    Declare @ClubCardBoostFlag      BIT
	BEGIN TRY

	SET @ProcSection = 'Section Reading XML'
	-- Create an internal representation of the XML document.
	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @XmlDocument


	SELECT CampaignID
			,CampaignCode
			,DescriptionShort
			,DescriptionLong
			,Amount
			,CASE WHEN IsActive like 'true'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignTypeId
			,IsMutuallyExclusive
			,UsageTypeID
			,GetUTCDate() AS UTCUpdatedDateTime
	INTO #TempCampaignDetails		
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign',2)
		WITH (	CampaignId		BIGINT 'CampaignId',				--check on this
				CampaignCode		NVARCHAR(25),
				DescriptionShort	NVARCHAR(200),
				DescriptionLong		NVARCHAR(300),
				Amount				MONEY,
				IsActive			VARCHAR(5),
				CampaignTypeId		int,
				IsMutuallyExclusive	BIT,
				UsageTypeId         TINYINT './UsageType/UsageTypeId'
			  )
		  )TempCampaign
		  
	IF EXISTS (SELECT 1 FROM #TempCampaignDetails WHERE LEN(CampaignCode) = 0)
	BEGIN
		SET @ErrorMessage = 'Invalid Coupon Code is being transmitted. Please check.'
		
		RAISERROR (
				'%s',
				16,
				1,
				@ErrorMessage
			)
	END
	
	SELECT @CampaignID = CampaignID,
			@CampaignTypeId = CampaignTypeId ,@UsageTypeNew=UsageTypeId
	FROM  #TempCampaignDetails
	
SELECT @UsageType=UsageTypeID from Coupon.Campaign where CampaignID=@CampaignID

	SELECT 
			*
	INTO #TempPlanID		
	FROM (			
		SELECT *
FROM   OPENXML(@XmlDocumentHandle, 'Campaign/SubscriptionPlanIds/string', 2)
       WITH ([PlanID] INT '.')
		  )TempPlans

SELECT 
			*
	INTO #TempDiscountTypes
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignDiscounts/DiscountType',2)
		WITH (	DiscountTypeId			TINYINT,
				DiscountTypeValue       DECIMAL(6,2)				--check on this
			  )
		  )TempDiscounts
	

	SELECT CustomerID
			,CouponCode
			,Amount
			,RedeemCount
			,CASE WHEN IsActive like 'True'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignID
			,ActionFlag				
	INTO #TempLinkedCouponDetails
	FROM(
	SELECT *
	FROM OPENXML (@XmlDocumentHandle, 'Campaign/Coupons/Coupon',2)
	WITH (	CustomerID			BIGINT  'CustomerIds/string',
			CouponCode			NVARCHAR(25)   './CouponCode',
			Amount				MONEY,
			RedeemCount			INT,
			IsActive			VARCHAR(5),
			CampaignID			BIGINT,
			ActionFlag			VARCHAR(10)
		  )
		)TempCoupon
				  
	SELECT @RecordsToAdd = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 1 --Getting records to insert
	
	SELECT @RecordsToDelete = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 0 --Getting records to delete
	
	--SELECT @RecordsToDeleteCoup = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 0 AND IsRedeemed = 0 -- Getting coupons to delete
	
	--Attribute Details 
	SELECT TempAttributes.*						
	INTO #TempCampaignAttributes
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignAttributes/CampaignAttribute',3)
		WITH (AttributeID		SMALLINT,
			  AttributeValue	NVARCHAR(50)
			  )where AttributeID > 0
		)TempAttributes
	ORDER BY TempAttributes.AttributeId 

select @ClubCardBoostFlagNew=AttributeValue from #TempCampaignAttributes where AttributeID=7
select @ClubCardBoostFlag=AttributeValue from Coupon.CampaignAttributes where CampaignID=@CampaignID and  AttributeID=7 

	EXEC sp_xml_removedocument @XmlDocumentHandle


	BEGIN TRANSACTION [Save_CampaignDetails] 

	IF (@CampaignTypeId >=1 AND @CampaignTypeId <=3) --Editing Campaign Details for all Coupon(s)
	BEGIN
		
			SET @ProcSection = 'Update Section in Coupon.Campaign:'
				
			UPDATE [TescoSubscription].[Coupon].[Campaign]
					SET	CampaignCode = TCD.CampaignCode
						,DescriptionShort = TCD.DescriptionShort
						,DescriptionLong = TCD.DescriptionLong
						,Amount = 0
						,IsActive = TCD.IsActive
						--,CampaignTypeId = TCD.CampaignTypeId --campaigntypeid should not be allowed to change
						,IsMutuallyExclusive=TCD.IsMutuallyExclusive
						,UsageTypeID	=TCD.UsageTypeId				
						,UTCUpdatedDateTime = GETUTCDATE()
					FROM #TempCampaignDetails TCD
					INNER JOIN [TescoSubscription].[Coupon].[Campaign] C
						ON C.CampaignID = TCD.CampaignID			
						
			IF(@@ROWCOUNT <> 1)
			BEGIN			
				SET @ErrorMessage = 'Failed in ' + @ProcSection
				
				RAISERROR (
							'%s',
							16,
							1,
							@ErrorMessage
							)
			END
			
		SET @ProcSection = 'Update Section Coupon.CampaignPlanDetails: '	
		
		DELETE FROM Coupon.CampaignPlanDetails 
		WHERE CampaignID=@CampaignID 
		AND SubscriptionPlanID NOT IN (SELECT [PlanID] FROM #TempPlanID)

		INSERT INTO Coupon.CampaignPlanDetails  
		 (CampaignID
		,SubscriptionPlanID 
		,UTCCreatedDateTime
		,UTCUpdatedDateTime
		)
		SELECT 
		@CampaignID
		,PlanID
		,getutcdate()
		,getutcdate()
		 FROM #TempPlanID WHERE PlanID  NOT IN 
		(SELECT SubscriptionPlanID FROM Coupon.CampaignPlanDetails 
		WHERE CampaignId = @CampaignID) 

		SET @ProcSection = 'Update Section Coupon.CampaignDiscountType: '	
		
		DELETE FROM Coupon.CampaignDiscountType
        WHERE CampaignID = @CampaignID 
        AND DiscountTypeID NOT IN (SELECT DiscountTypeID FROM #TempDiscountTypes WHERE CampaignID = @CampaignID)
		
		UPDATE Coupon.CampaignDiscountType 
		SET DiscountValue=DiscountTypeValue,
			UTCUpdatedDateTime=GETUTCDATE()
		FROM #TempDiscountTypes TD INNER JOIN
		Coupon.CampaignDiscountType CD ON
		CD.CampaignID=@CampaignID
		AND CD.DiscountTypeID=TD.DiscountTypeId

		INSERT INTO [Coupon].[CampaignDiscountType] (
            CampaignID,
            DiscountTypeID,
            DiscountValue,
			UTCCreatedDateTime,
			UTCUpdatedDateTime
            )
            SELECT 
            @CampaignID,
            DiscountTypeID,
            DiscountTypeValue,
			getutcdate(),
			getutcdate()
            FROM #TempDiscountTypes 
            WHERE DiscountTypeID NOT IN 
			(SELECT DiscountTypeID FROM [Coupon].[CampaignDiscountType] WHERE CampaignID = @CampaignID)

			SET @ProcSection = 'Update Section Coupon.CampaignAttributes: '			
			
			UPDATE [TescoSubscription].[Coupon].[CampaignAttributes]
				SET	AttributeValue = TCA.AttributeValue,
					UTCUpdatedDateTime = GETUTCDATE()
				FROM #TempCampaignAttributes TCA
				INNER JOIN Coupon.CampaignAttributes CA
					   ON  CA.CampaignID = @CampaignID
					   AND CA.AttributeId = TCA.AttributeId	

			IF NOT (@UsageType = @UsageTypeNew)
				BEGIN
				 IF (@UsageTypeNew=1)
					BEGIN
					INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
									   ([CampaignID]
									   ,[AttributeID]
									   ,[AttributeValue]
									   ,[UTCCreatedDateTime]
									   ,[UTCUpdatedDateTime])
								SELECT @CampaignID
										,AttributeID
										,AttributeValue
										,GetUTCDate() AS [UTCCreatedeDateTime]
										,GetUTCDate() AS [UTCUpdatedDateTime]
								FROM #TempCampaignAttributes WHERE AttributeID=5
					END
				   ELSE IF(@UsageTypeNew=2)
						BEGIN
							DELETE FROM [TescoSubscription].[Coupon].[CampaignAttributes]
							WHERE CampaignID=@CampaignID and AttributeID=5			

						END

			END			

			IF NOT (@ClubCardBoostFlag = @ClubCardBoostFlagNew)
				BEGIN
				 IF (@ClubCardBoostFlagNew=1)
					BEGIN
					INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
									   ([CampaignID]
									   ,[AttributeID]
									   ,[AttributeValue]
									   ,[UTCCreatedDateTime]
									   ,[UTCUpdatedDateTime])
								SELECT @CampaignId
										,AttributeID
										,AttributeValue
										,GetUTCDate() AS [UTCCreatedeDateTime]
										,GetUTCDate() AS [UTCUpdatedDateTime]
								FROM #TempCampaignAttributes WHERE AttributeID=8
					END
				 ELSE IF(@ClubCardBoostFlagNew=0)
						BEGIN
							DELETE FROM [TescoSubscription].[Coupon].[CampaignAttributes]
							WHERE CampaignID=@CampaignID and AttributeID=8			

						END

			END		

		
				
			IF (@RecordsToAdd <> 0)
			BEGIN
			
			/*ADD SECTION BEGINS */
			
				SET @ProcSection = 'Add Section in Coupon.Coupon: '
					
					
					INSERT INTO [TescoSubscription].[Coupon].[Coupon]
						   ([CouponCode]
						   ,[Amount]
						   ,[RedeemCount]
						   ,[IsActive]
						   ,[UTCCreatedeDateTime]
						   ,[UTCUpdatedDateTime]
						   ,[CampaignID])
					SELECT CouponCode
							,0
							,RedeemCount
							,IsActive					
							,GetUTCDate() AS [UTCCreatedeDateTime]
							,GetUTCDate() AS [UTCUpdatedDateTime]
							,@CampaignID
					FROM #TempLinkedCouponDetails TCD
					WHERE Tcd.IsActive = 1
						
					IF(@@ROWCOUNT <> @RecordsToAdd)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END		
				
					SET @ProcSection = 'Add Section Coupon.CouponCustomerMap: '
					
					INSERT INTO [TescoSubscription].[Coupon].[CouponCustomerMap]
					   ([CouponID]
					   ,[CustomerID]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
					Select Cpn.CouponID
							,Tcd.CustomerID
							,GetUTCDate() AS [UTCCreatedDateTime]
							,GetUTCDate() AS [UTCUpdatedDateTime]
					FROM #TempLinkedCouponDetails Tcd
					INNER JOIN Coupon.Coupon Cpn
						ON LOWER(Tcd.CouponCode) = LOWER(Cpn.CouponCode)
						AND Tcd.IsActive = 1
												
					IF(@@ROWCOUNT <> @RecordsToAdd)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END	
			END			
						
		/*ADD SECTION ENDS*/
		
		

		/*DELETE SECTION BEGINS*/			
			IF (@RecordsToDelete <> 0)
			BEGIN
				SET @ProcSection = 'Delete Section Coupon.CouponCustomerMap: '
				
				DELETE FROM [TescoSubscription].[Coupon].[CouponCustomerMap] 
				WHERE CouponID IN (
									SELECT Cpn.CouponID														
									FROM #TempLinkedCouponDetails Tcd
									INNER JOIN Coupon.Coupon Cpn
										ON Lower(Tcd.CouponCode) = Lower(Cpn.CouponCode)
										AND Tcd.IsActive = 0										
										)
					
				IF(@@ROWCOUNT <> @RecordsToDelete)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END	
					
				
				SET @ProcSection = 'Delete Section Coupon.Coupon: '					 
				
				DELETE FROM [TescoSubscription].[Coupon].[Coupon]  
				WHERE CouponCode IN (SELECT TCD.CouponCode 
										FROM #TempLinkedCouponDetails Tcd
											WHERE Tcd.IsActive = 0
											AND NOT EXISTS (SELECT 1 FROM Coupon.CouponRedemption Cr (NOLOCK)
											WHERE Tcd.CouponCode = Cr.CouponCode)
											)
					
					
    		END		
		/*DELETE SECTION ENDS*/	
		
		COMMIT TRANSACTION [Save_CampaignDetails]
						
		END
	
		IF (@CampaignTypeId < 1 OR @CampaignTypeId > 3)
			BEGIN
				SET @ErrorMessage = 'Unrecognised CampaignType supplied in XML '
				
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION [Save_CampaignDetails]
				END
				
				RAISERROR (
						'%s',
						16,
						1,
						@ErrorMessage
						)
			END		
					
		--Removing Temporary Table(S)
		
		DROP TABLE #TempCampaignDetails
		
		DROP TABLE #TempLinkedCouponDetails
			
		DROP TABLE #TempCampaignAttributes

		DROP TABLE #TempDiscountTypes

		DROP TABLE #TempPlanID	
		PRINT 'CAMPAIGN AND COUPON(S) EDITED IN DATABASE FOR ' + CONVERT(NVARCHAR(100),@CampaignID) + ' CampaignID'
		
	END TRY	
	
	BEGIN CATCH
			SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
	
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [Save_CampaignDetails]
			END

			IF OBJECT_ID('tempdb..#TempCampaignDetails') IS NOT NULL DROP TABLE #TempCampaignDetails
			IF OBJECT_ID('tempdb..#TempLinkedCouponDetails') IS NOT NULL DROP TABLE #TempLinkedCouponDetails
			IF OBJECT_ID('tempdb..#TempCampaignAttributes') IS NOT NULL DROP TABLE #TempCampaignAttributes
			IF OBJECT_ID('tempdb..#TempPlanID') IS NOT NULL DROP TABLE #TempPlanID
			IF OBJECT_ID('tempdb..#TempDiscountTypes') IS NOT NULL DROP TABLE #TempDiscountTypes
			RAISERROR (
					'SP - [coupon].[CampaignEdit1] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)
	END CATCH

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignEdit1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignEdit1]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit1] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CampaignEdit1] not created.',
        16,
        1
    )
END
GO







USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignStop]

		IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignStop] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignStop] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignStop]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignStop]
** DATE WRITTEN   : 27/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignStop] 
(
@CampaignID	BIGINT
)
AS

BEGIN

SET NOCOUNT ON;
DECLARE @ErrorMessage		NVARCHAR(2048)

BEGIN TRY

	BEGIN TRANSACTION [Stop_CampaignCoupon]
	
	UPDATE Coupon.Coupon
	SET	
		IsActive = 0,
		UTCUpdatedDateTime = GETUTCDATE()	
		WHERE 
			CouponID IN (SELECT CouponID 
							FROM Coupon.Coupon C
							WHERE CampaignID = @CampaignID)
	IF (@@ROWCOUNT <> 0)
	BEGIN
		UPDATE Coupon.Campaign
		SET	
			IsActive = 0,
			UTCUpdatedDateTime = GETUTCDATE()	
			WHERE 
				CampaignID = @CampaignID
	END
	ELSE
	BEGIN
		SET @ErrorMessage = 'Coupon to be stopped not found for supplied CampaignID'
		
		RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
	END
	
	COMMIT TRANSACTION 	[Stop_CampaignCoupon]
	PRINT 'CAMPAIGN AND COUPON(S) STOPPED'		
		
END TRY	
BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()

		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION [Stop_CampaignCoupon]
		END
		
		RAISERROR (
				'SP - [coupon].[CampaignStop] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
END CATCH

END
GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignStop] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignStop] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignStop] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignTypeGet]

		IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignTypeGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignTypeGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignTypeGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[CampaignTypeGet]
** DATE WRITTEN   : 06/04/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): DATA OF TABLE [Coupon].[CampaignTypeGet] WHICH IS ACTIVE
*******************************************************************************************  
*******************************************************************************************/

CREATE PROCEDURE [Coupon].[CampaignTypeGet]
AS


BEGIN

	SET NOCOUNT ON;	

	SELECT 
		CampaignTypeID as [CampaignTypeId],
		CampaignTypeName as [CampaignTypeName],
		Description
	FROM [Coupon].[CampaignTypeMaster]
	WHERE IsActive = 1 --Active Campaign
	--FOR XML PATH('SubscriptionCouponType'),TYPE,root('SubscriptionCouponTypes')

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignTypeGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignTypeGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignTypeGet] not created.',16,1)
	END
GOIF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsGet]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet] not dropped.',16,1)
			END
	END
GO





CREATE PROCEDURE [Coupon].[CouponDetailsGet]
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

	SELECT 
		CouponCode,
		DescriptionShort,
		DescriptionLong,
		Amount,
		RedeemCount,
		IsActive	
	FROM
		Coupon.Coupon c (NOLOCK)
	WHERE
		CouponCode = @CouponCode


	SELECT 
		ca.AttributeId,
		ca.AttributeValue
	FROM
		Coupon.Coupon c (NOLOCK)
	INNER JOIN 
		Coupon.CouponAttributes ca (NOLOCK)
	ON c.CouponID = ca.CouponID
	WHERE
		CouponCode = @CouponCode
	ORDER BY ca.AttributeId

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsGet1]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet1] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [Coupon].[CouponDetailsGet1]
(
	@CouponCode				NVARCHAR(25)	
)
AS


/*
	Author:		Robin
	Created:	15/Jul/2013
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN

	SET NOCOUNT ON;	

-- To get Coupon Details

SELECT 
		CC.CouponCode,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CM.Amount,
		CC.RedeemCount,
		CC.IsActive,
        CM.campaignTypeID CouponType
        FROM Coupon.Coupon CC (NOLOCK)
        INNER JOIN Coupon.Campaign CM (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        WHERE CouponCode = @CouponCode



-- To get the CustomerID for the LinkedCoupons  CASE WHEN TM.CampaignTypeID IN (1,2) THEN NULL ELSE 

    SELECT CM.CustomerID  CustomerID
    FROM [Coupon].[CouponCustomerMap] CM (NOLOCK)
    INNER JOIN [Coupon].[Coupon] CC (NOLOCK)
    ON CM.CouponID = CC.CouponID
    INNER JOIN [Coupon].[Campaign] CI (NOLOCK)
    ON CC.CampaignID = CI.CampaignID
    WHERE  CC.CouponCode = @CouponCode AND CI.CampaignTypeID=3


-- To get Coupons attributes

	SELECT 
		ca.AttributeId,
		ca.AttributeValue
	FROM
		Coupon.Coupon c (NOLOCK)
	INNER JOIN 
		Coupon.CampaignAttributes ca (NOLOCK)
	ON c.campaignid = ca.campaignid
	WHERE
		CouponCode = @CouponCode
	ORDER BY ca.AttributeId

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet1] not created.',16,1)
	END
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet2]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsGet2]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsGet2]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet2] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsGet2] not dropped.',
            16,
            1
        )
    END
END

GO


CREATE PROCEDURE [Coupon].[CouponDetailsGet2]
(
	@CouponCode				NVARCHAR(MAX)
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
BEGIN

	SET NOCOUNT ON;	

DECLARE

@Delimiter    NVARCHAR(1)

SET @Delimiter = ','

DECLARE @CouponTable TABLE  (String NVARCHAR(MAX))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))


-- To get the distinct coupon codes
SELECT 
		CC.CouponCode,
        CC.CouponID,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CM.IsActive,
        CM.campaignTypeID CouponType,
		CM.IsMutuallyExclusive
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        WHERE  CC.CouponCode  IN (SELECT String FROM @CouponTable)

-- In case of Linked Coupon

SELECT CC.CouponCode,
       CM.CustomerID
       FROM Coupon.Coupon CC  WITH (NOLOCK)
       INNER JOIN Coupon.CouponCustomerMap CM  WITH (NOLOCK)
       ON CC.CouponID = CM.CouponID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable)   

--  Get coupon Discount TypeID
 
SELECT CC.CouponCode,
       CD.DiscountTypeID,
	   CD.DiscountValue
       FROM Coupon.Coupon CC  WITH (NOLOCK)
       INNER JOIN Coupon.CampaignDiscountType CD  WITH (NOLOCK)
       ON CC.CampaignID = CD.CampaignID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable) 

--Get the coupon Attributes


SELECT CC.CouponCode,
       CA.AttributeID,
	   CA.AttributeValue
       FROM Coupon.Coupon CC  WITH (NOLOCK)
       INNER JOIN Coupon.CampaignAttributes CA  WITH (NOLOCK)
       ON CC.CampaignID = CA.CampaignID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable) 
  
--Get the Plan IDs comma seperated per coupon    
SELECT DISTINCT(C.CouponCode), 
    SUBSTRING(
        (
            SELECT ','+ CONVERT(VARCHAR,CPD1.SubscriptionPlanID) AS [text()]
            From Coupon.CampaignPlanDetails CPD1
            Where CPD1.CampaignID = CPD2.CampaignID
            ORDER BY CPD1.CampaignID
            For XML PATH ('')
        ), 2, 1000) [PlanIDs]
From Coupon.CampaignPlanDetails CPD2 WITH (NOLOCK)
INNER JOIN Coupon.Coupon C   WITH (NOLOCK)
ON CPD2.CampaignID = C.CampaignID 
INNER JOIN @CouponTable CT 
ON CT.[String] = C.CouponCode

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet2] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet2]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet2] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsGet2] not created.',
        16,
        1
    )
END
GO


USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsGet3]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet3] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsGet3] not dropped.',
            16,
            1
        )
    END
END

GO
CREATE PROCEDURE [Coupon].[CouponDetailsGet3]
(
	@CouponCode				NVARCHAR(200)
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
BEGIN

	SET NOCOUNT ON;	
DECLARE

@Delimiter    NVARCHAR(1)

SET @Delimiter = ','

DECLARE 
@CouponTable  TABLE (String NVARCHAR(44))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))

SELECT 
		CC.CouponCode,
        CC.CouponID,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CM.IsActive,
        CM.campaignTypeID CouponType,
        DM.DiscountTypeId,
        DT.Discountvalue,
        DM.DiscountName       
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        INNER JOIN Coupon.CampaignDiscountType DT WITH (NOLOCK)
        ON CM.CampaignID = DT.CampaignID
        INNER JOIN Coupon.DiscountTypeMaster DM WITH (NOLOCK) 
        ON DT.DiscountTypeID = DM.DiscountTypeID
        WHERE  CC.CouponCode  IN (SELECT String FROM @CouponTable)

-- In case of Linked Coupon

SELECT CC.CouponCode,
       CM.CustomerID
       FROM Coupon.Coupon CC WITH (NOLOCK)
       INNER JOIN Coupon.CouponCustomerMap CM WITH (NOLOCK)
       ON CC.CouponID = CM.CouponID
       Where CC.CouponCode IN (SELECT String FROM @CouponTable)     

END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet3] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet3] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsGet3] not created.',
        16,
        1
    )
END
GO



IF OBJECT_ID(N'[Coupon].[CouponDetailsGet4]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsGet4]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsGet4]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet4] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsGet4] not dropped.',
            16,
            1
        )
    END
END

GO


CREATE PROCEDURE [Coupon].[CouponDetailsGet4]
(
	@CouponCode				NVARCHAR(MAX)
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
BEGIN

	SET NOCOUNT ON;	

DECLARE

@Delimiter    NVARCHAR(1)

SET @Delimiter = ','

DECLARE @CouponTable TABLE  (String NVARCHAR(MAX))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))


-- To get the distinct coupon codes
SELECT 
		CC.CouponCode,
        CC.CouponID,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CM.IsActive,
        CM.campaignTypeID CouponType,
		CM.IsMutuallyExclusive
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        WHERE  CC.CouponCode  IN (SELECT String FROM @CouponTable)

-- In case of Linked Coupon

SELECT CC.CouponCode,
       CM.CustomerID
       FROM Coupon.Coupon CC
       INNER JOIN Coupon.CouponCustomerMap CM
       ON CC.CouponID = CM.CouponID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable)   

--  Get coupon Discount TypeID
 
SELECT CC.CouponCode,
       CD.DiscountTypeID,
	   CD.DiscountValue
       FROM Coupon.Coupon CC
       INNER JOIN Coupon.CampaignDiscountType CD
       ON CC.CampaignID = CD.CampaignID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable) 

--Get the coupon Attributes


SELECT CC.CouponCode,
       CA.AttributeID,
	   CA.AttributeValue
       FROM Coupon.Coupon CC
       INNER JOIN Coupon.CampaignAttributes CA
       ON CC.CampaignID = CA.CampaignID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable) 

END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet4] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet4]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet4] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsGet4] not created.',
        16,
        1
    )
END
GO


IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponDetailsGetAll]
    
    IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsGetAll] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponDetailsGetAll] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponDetailsGetAll]
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Get All Coupons Details


Example:
Execute [coupon].[CouponDetailsGetAll]
--Modifications History--
Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;	
	
	SELECT c.CouponID,
	       c.CouponCode,
	       c.DescriptionShort,
	       c.DescriptionLong,
	       c.Amount,
	       c.RedeemCount,
	       c.IsActive,
	       c.UTCCreatedeDateTime,
	       (
	           SELECT ca.AttributeID,
	                  ca.AttributeValue 
	           FROM   Coupon.CouponAttributes ca	           
	           WHERE  ca.CouponID = c.CouponID
	                  FOR XML PATH('CouponAttribute'),TYPE, ROOT('CouponAttributes')
	       ) Attributes
	FROM   Coupon.Coupon c (NOLOCK)	
	ORDER BY
	       c.UTCCreatedeDateTime DESC
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponDetailsGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsGetAll] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponDetailsGetAll] not created.',
        16,
        1
    )
END
GO
IF OBJECT_ID(N'[Coupon].[CouponDetailsSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsSave]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsSave] not dropped.',16,1)
			END
	END
GO

    
CREATE PROCEDURE [Coupon].[CouponDetailsSave] 
(@CouponDetailsXML XML)
AS
	/*   
Author:  Swaraj    
Created: 04/Oct/2012    
Purpose: Save Coupons Details    

Example:    
Execute [coupon].[CouponDetailsSave] @CouponDetailsXML =     
'    
<ArrayOfCouponDetails>  
<CouponDetails CouponID="0" CouponCode="DDWDQ" DescriptionShort="Testing ADD" DescriptionLong="New" Amount="15.0000" RedeemCount="0" IsActive="false" UTCCreatedeDateTime="2012-10-10T00:00:00" UTCUpdatedDateTime="2012-10-10T00:00:00">  
<CouponAttributesList>  
<CouponAttribute>  
<AttributeID>1</AttributeID><AttributeValue>1</AttributeValue>  
</CouponAttribute>  
<CouponAttribute>  
<AttributeID>2</AttributeID><AttributeValue>2012/10/06</AttributeValue>  
</CouponAttribute>  
<CouponAttribute>  
<AttributeID>3</AttributeID><AttributeValue>2012/10/14</AttributeValue>  
</CouponAttribute>  
<CouponAttribute>  
<AttributeID>4</AttributeID><AttributeValue>500</AttributeValue>  
</CouponAttribute>  
<CouponAttribute>  
<AttributeID>5</AttributeID><AttributeValue>15</AttributeValue>  
</CouponAttribute>  
</CouponAttributesList>  
</CouponDetails>  
</ArrayOfCouponDetails>  
'    
--Modifications History--    
Changed On   Changed By  Defect  Changes  Change Description     

*/   

BEGIN
	SET NOCOUNT ON;     
	DECLARE @ErrorMessage    NVARCHAR(2048),
	        @CurrentUTCDate  SMALLDATETIME  
	
	CREATE TABLE #couponDetails
	(
		[CouponID]          [bigint] NOT NULL,
		[CouponCode]        [nvarchar](25) NOT NULL,
		[DescriptionShort]  [nvarchar](200) NULL,
		[DescriptionLong]   [nvarchar](300) NULL,
		[Amount]            [money],
		[IsActive]          [bit] NOT NULL DEFAULT((0)),
		AttributeId         SMALLINT NULL,
		AttributeValue      VARCHAR(50)
	)    
	
	SELECT @CurrentUTCDate = GETUTCDATE()
		
	INSERT INTO #couponDetails
	  (
	    CouponID,
	    CouponCode,
	    DescriptionShort,
	    DescriptionLong,
	    Amount,
	    IsActive,
	    AttributeId,
	    AttributeValue
	  )
	SELECT T.C.value('../../@CouponID[1]', 'bigint') [CouponID],
	       T.C.value('../../@CouponCode[1]', 'nvarchar(25)') [CouponCode],
	       T.C.value('../../@DescriptionShort[1]', 'NVARCHAR(200)') 
	       [DescriptionShort],
	       T.C.value('../../@DescriptionLong[1]', 'NVARCHAR(300)') 
	       [DescriptionLong],
	       T.C.value('../../@Amount[1]', 'money') Amount,
	       T.C.value('../../@IsActive[1]', 'bit') [IsActive],
	       T.C.value('AttributeID[1]', 'smallint') AttributeID,
	       T.C.value('AttributeValue[1]', 'nvarchar(50)') AttributeValue
	FROM   @CouponDetailsXML.nodes(
	           'ArrayOfCouponDetails/CouponDetails/CouponAttributesList/CouponAttribute'
	       ) T(c)    
	
	BEGIN TRY
		BEGIN TRANSACTION Save_CouponDetails 
		--Update  Coupon.Coupon
		--   
		
		UPDATE Coupon.Coupon
		SET    DescriptionShort = cd.DescriptionShort,
		       DescriptionLong = cd.DescriptionLong,
		       Amount = cd.Amount,
		       IsActive = cd.IsActive,		       
		       UTCUpdatedDateTime = @CurrentUTCDate
		FROM   #couponDetails cd
		       INNER JOIN Coupon.Coupon c
		            ON  c.CouponID = cd.CouponID 
		
		--update Coupon.CouponAttributes    
		UPDATE Coupon.CouponAttributes
		SET    AttributeValue = cd.AttributeValue,
		       UTCUpdatedDateTime = @CurrentUTCDate
		FROM   #couponDetails cd
		       INNER JOIN Coupon.CouponAttributes ca
		            ON  ca.CouponID = cd.CouponID
		            AND ca.AttributeId = cd.AttributeId 
		
		--Insert into Coupon.Coupon    
		INSERT INTO Coupon.Coupon
		  (
		    CouponCode,
		    DescriptionShort,
		    DescriptionLong,
		    Amount,
		    IsActive
		  )
		SELECT DISTINCT 
		       cd.CouponCode,
		       cd.DescriptionShort,
		       cd.DescriptionLong,
		       cd.Amount,
		       cd.IsActive
		FROM   #couponDetails cd
		       LEFT JOIN Coupon.Coupon c
		            ON  c.CouponID = cd.CouponID
		WHERE  c.CouponID IS NULL   
		
		INSERT INTO coupon.CouponAttributes
		  (
		    CouponID,
		    AttributeID,
		    AttributeValue
		  )
		SELECT C.CouponId,
		       cd.AttributeId,
		       cd.AttributeValue  
		FROM   #couponDetails CD
		       JOIN Coupon.Coupon C
		            ON  CD.CouponCode = C.CouponCode
		       LEFT JOIN Coupon.CouponAttributes ca
		            ON  ca.CouponID = C.CouponID
		            AND ca.AttributeId = CD.AttributeId
		WHERE  CA.AttributeID IS NULL 
		
		COMMIT TRANSACTION [Save_CouponDetails]
	END TRY    
	BEGIN CATCH		 
	    SET @ErrorMessage = ERROR_MESSAGE()
	     
		IF @@TRANCOUNT > 0
		BEGIN
		    ROLLBACK TRANSACTION [Save_CouponDetails]
		END 
		
		RAISERROR (
		    'SP - [coupon].[CouponDetailsSave] Error = (%s)',
		    16,
		    1,
		    @ErrorMessage
		)
	END CATCH 
	
	DROP TABLE #couponDetails
END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsSave] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CouponDetailsValidate]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsValidate]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsValidate]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsValidate] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsValidate] not dropped.',
            16,
            1
        )
    END
END

GO
CREATE PROCEDURE [Coupon].[CouponDetailsValidate]
(
	@CouponCode				NVARCHAR(25)	
)
AS


/*
	Author:		Robin
	Created:	20/Feb/2014
	Purpose:	Get coupon detils for validation based on couponCode
    Called By:  Coupon Service

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN

	SET NOCOUNT ON;	

DECLARE 
@listStr VARCHAR(200), 
@CampaignID BIGINT 

		SELECT @listStr = COALESCE(@listStr + ', ' ,'') + CONVERT(VARCHAR,PD.SubscriptionPlanID),@CampaignID= CC.CampaignID  
		FROM Coupon.CampaignPlanDetails PD WITH (NOLOCK)
		INNER JOIN Coupon.Coupon CC WITH (NOLOCK)
		ON CC.CampaignID = PD.CampaignID 
		WHERE CC.CouponCode = @CouponCode

;WITH PlanIDCTE(PlanIDs,CampaignID) AS (SELECT @listStr,@CampaignID)

-- To get Coupon Details

		SELECT 
		CC.CouponCode,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CC.IsActive,
        CM.campaignTypeID CouponType,
        PD.PlanIDs,
		CM.UsageTypeID
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        LEFT JOIN PlaniDCTE PD
        ON PD.CampaignID = CC.CampaignID
        WHERE CouponCode = @CouponCode


-- To get the CustomerID for the LinkedCoupons  CASE WHEN TM.CampaignTypeID IN (1,2) THEN NULL ELSE 

		SELECT 
		CM.CustomerID AS CustomerID
		FROM [Coupon].[CouponCustomerMap] CM WITH (NOLOCK)
		INNER JOIN [Coupon].[Coupon] CC WITH (NOLOCK)
		ON CM.CouponID = CC.CouponID
		INNER JOIN [Coupon].[Campaign] CI WITH (NOLOCK)
		ON CC.CampaignID = CI.CampaignID
		WHERE  CC.CouponCode = @CouponCode AND CI.CampaignTypeID=3


-- To get Coupons attributes

		SELECT 
		ca.AttributeId,
		ca.AttributeValue
		FROM Coupon.Coupon CC WITH (NOLOCK)
		INNER JOIN Coupon.CampaignAttributes CA WITH (NOLOCK)
		ON CC.campaignid = CA.campaignid
        WHERE CC.CouponCode = @CouponCode
		AND CA.AttributeId <>1
		ORDER BY CA.AttributeId

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsValidate] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsValidate]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsValidate] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsValidate] not created.',
        16,
        1
    )
END
GO

IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponDetailsXMLGet]
    
    IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsXMLGet] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponDetailsXMLGet] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponDetailsXMLGet]
(
	@couponId BIGINT
)
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Get Coupons Details of Single Coupon


Example:
Execute [coupon].[CouponDetailsXMLGet] 70
--Modifications History--
Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;	
	
	SELECT c.CouponID,
	       c.CouponCode,
	       c.DescriptionShort,
	       c.DescriptionLong,
	       c.Amount,
	       c.RedeemCount,
	       c.IsActive,
	       c.UTCCreatedeDateTime,
	       (
	           SELECT ca.AttributeID,
	                  ca.AttributeValue
	           FROM   Coupon.CouponAttributes ca
	           WHERE  ca.CouponID = c.CouponID
	                  FOR XML PATH('CouponAttribute'),TYPE, ROOT('CouponAttributes')
	       ) Attributes
	FROM   Coupon.Coupon c 
	WHERE c.CouponId = @couponId
	ORDER BY
	       c.UTCCreatedeDateTime DESC
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponDetailsXMLGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsXMLGet] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponDetailsXMLGet] not created.',
        16,
        1
    )
END
GO
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
IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponRedemptionSave]

		IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponRedemptionSave] not dropped.',16,1)
			END
	END
GO





CREATE PROCEDURE [Coupon].[CouponRedemptionSave]
(
	@CouponCode NVARCHAR(25)
	,@CustomerID BIGINT	
)
AS

/*
	Author:		Manjunathan
	Created:	18/Sep/2012
	Purpose:	Create Coupon Redemption

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

	*/

BEGIN
	SET NOCOUNT ON;	

	DECLARE	 @errorDescription	NVARCHAR(2048)
		,@error				INT
		,@errorProcedure	SYSNAME
		,@errorLine			INT
	  
	BEGIN TRY
 
	BEGIN TRANSACTION
		
	INSERT INTO [TescoSubscription].[Coupon].[CouponRedemption]
           ([CouponCode]
           ,[CustomerID]           )
     VALUES
           (@CouponCode
			,@CustomerID)
			
	UPDATE Coupon.Coupon
	SET RedeemCount = RedeemCount + 1
		,UTCUpdatedDateTime = GETUTCDATE()
	WHERE 
		CouponCode = @CouponCode
		
	COMMIT TRANSACTION 
	
	END TRY
	BEGIN CATCH

	  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
				  , @error                = ERROR_NUMBER()
				  , @errorDescription     = ERROR_MESSAGE()
				  , @errorLine            = ERROR_LINE()
	  FROM  INFORMATION_SCHEMA.ROUTINES
	  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

	 ROLLBACK TRANSACTION 
	 
	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
 
	END CATCH


END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponRedemptionSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponRedemptionSave] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponRedemptionSave3]
    
    IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave3] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponRedemptionSave3] not dropped.',
            16,
            1
        )
    END
END

GO

CREATE PROCEDURE [Coupon].[CouponRedemptionSave3]
(
	@CouponCode NVARCHAR(MAX)
   ,@CustomerID BIGINT	
)
AS
/*
	Author:		Robin
	Created:	21 Jan 2014 
	Purpose:	To increase the coupon redemption count and map customerid to couponid

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;	


	SET NOCOUNT ON;	

DECLARE
 @errorDescription	NVARCHAR(2048)
,@error				INT
,@errorProcedure	SYSNAME
,@errorLine			INT
,@Delimiter    NVARCHAR(1)
,@String       NVARCHAR(25)
 
SET @Delimiter = ','

DECLARE @CouponTable  TABLE (String NVARCHAR(44))
 

INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))

--    END

	  
    BEGIN TRY
 
		BEGIN TRANSACTION
	--SELECT 1/0
		INSERT INTO [Coupon].[CouponRedemption]
			 ([CouponCode]
			 ,[CustomerID])
				(SELECT UPPER(String),@CustomerID FROM @CouponTable)

	     
				
		UPDATE [Coupon].[Coupon]
		SET RedeemCount = RedeemCount + 1
			,UTCUpdatedDateTime = GETUTCDATE()
		WHERE 
			CouponCode IN (SELECT String FROM @CouponTable)

		 
			
		COMMIT TRANSACTION 
		
	END TRY
	BEGIN CATCH

		 SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
					  , @error                = ERROR_NUMBER()
					  , @errorDescription     = ERROR_MESSAGE()
					  , @errorLine            = ERROR_LINE()
		 FROM  INFORMATION_SCHEMA.ROUTINES
		 WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		 ROLLBACK TRANSACTION 
		 
		 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 
	END CATCH


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponRedemptionSave3] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave3] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponRedemptionSave3] not created.',
        16,
        1
    )
END
GO

IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponStop]
    
    IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponStop] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponStop] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponStop]
(
    @CouponId Bigint
)
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Stop a Coupons

execute coupon.couponstop 1
--Modifications History--
Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;
	
	UPDATE Coupon.Coupon
		SET	
			IsActive = 0,
			UTCUpdatedDateTime = GETUTCDATE()	
		WHERE 
			CouponID = @CouponId
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponStop] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponStop] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponStop] not created.',
        16,
        1
    )
END
GO
USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CouponUnredemptionSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponUnredemptionSave]

		IF OBJECT_ID(N'[Coupon].[CouponUnredemptionSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponUnredemptionSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponUnredemptionSave] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CouponUnredemptionSave]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CouponUnredemptionSave]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	15 Jul 2013		Navdeep_Singh					RedemptionFix of value 1
	23 Jul 2013		Navdeep_Singh					Incorporating Manju's logic fro redemption

*/

CREATE PROCEDURE [Coupon].[CouponUnredemptionSave]
(
	@CouponCode NVARCHAR(25)
	,@CustomerID BIGINT	
)
AS

BEGIN
	SET NOCOUNT ON;	

	DECLARE	 @errorDescription	NVARCHAR(2048)
		,@error				INT
		,@errorProcedure	SYSNAME
		,@errorLine			INT
	  
	BEGIN TRY
 
	BEGIN TRANSACTION 
		
	;WITH DelCoup AS
	( SELECT TOP 1 CouponCode FROM [TescoSubscription].[Coupon].[CouponRedemption]
      WHERE CustomerID = @CustomerID AND CouponCode=@CouponCode
      ORDER BY UTCCreatedDateTime DESC 
	)

	DELETE FROM DelCoup
      
	
	IF @@ROWCOUNT = 1 
	BEGIN		
		UPDATE Coupon.Coupon
		SET RedeemCount = RedeemCount - 1
			,UTCUpdatedDateTime = GETUTCDATE()
		WHERE 
			CouponCode = @CouponCode
		
	COMMIT TRANSACTION 	

	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION 
		
		RAISERROR (
				'SP - [coupon].[CouponUnRedemptionSave] Error = (%s)',
				16,
				1,
				'No record'
				)
	END	
	
	

	END TRY
	BEGIN CATCH

	IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION 
			END

	  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
				  , @error                = ERROR_NUMBER()
				  , @errorDescription     = ERROR_MESSAGE()
				  , @errorLine            = ERROR_LINE()
	  FROM  INFORMATION_SCHEMA.ROUTINES
	  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
 
	END CATCH


END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponUnredemptionSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponUnredemptionSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponUnredemptionSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponUnredemptionSave] not created.',16,1)
	END
GO

USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupon]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[SearchCoupon]

		IF OBJECT_ID(N'[Coupon].[SearchCoupon]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupon] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[SearchCoupon] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[SearchCoupon]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[SearchCoupon]
** DATE WRITTEN   : 11th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	23 July 2013	Navdeep_Singh					Incorporated Review Comments from Manju

*/

CREATE PROCEDURE Coupon.SearchCoupon
(
@CouponCode		NVARCHAR(25)	= NULL,
@CustomerID		BIGINT			= NULL
)
AS

BEGIN

SET NOCOUNT ON

DECLARE @ErrorMessage    NVARCHAR(2048)

IF (@CouponCode IS NULL AND @CustomerID IS NULL)
	BEGIN 
		SET @ErrorMessage = 'Either, CustomerID or CouponCode should be supplied'
			
		RAISERROR (
		'SP - [Coupon].[SearchCoupon] Error = %s',
		16,
		1,
		@ErrorMessage
		)
	END


IF (@CouponCode IS NOT NULL)
	BEGIN
	
	;WITH CampAttrUn
	AS
	(SELECT PVT.CampaignId
			,PVT.[1] SubscriptionPlanId
			,CAST(SUBSTRING(PVT.[2],6,2)+'/'+SUBSTRING(PVT.[2],9,2)+'/'+SUBSTRING(PVT.[2],1,4) AS VARCHAR(10)) EffectiveStartDateTime
			,CAST(SUBSTRING(PVT.[3],6,2)+'/'+SUBSTRING(PVT.[3],9,2)+'/'+SUBSTRING(PVT.[3],1,4) AS VARCHAR(10)) EffectiveEndDateTime
			,PVT.[4] MaxRedemption
			,PVT.[5] LapsePeriod
			,PVT.[6] CouponsGeneratedCount 
			,CouponID
		FROM
			(
			SELECT C.CampaignId,
					AttributeValue,
					AttributeID	
					,CouponID		
			FROM Coupon.Coupon CP (NOLOCK)
			JOIN Coupon.Campaign C  (NOLOCK)
			ON CouponCode=@CouponCode AND C.CampaignID=CP.CampaignID 	
			JOIN Coupon.CampaignAttributes CA  (NOLOCK)
				ON CA.CampaignID = C.CampaignID	
			) TempA
			PIVOT (
				 MIN(Attributevalue)
				 FOR AttributeID in ([1],[2],[3],[4],[5],[6])
			) PVT
		)			
		SELECT	C.CouponID													
				,C.CouponCode
				,Cmp.CampaignID
				,Cmp.CampaignCode
				,CONVERT(VARCHAR(10),CampAttrUn.EffectiveStartDateTime,101)		AS ValidFrom
				,CONVERT(VARCHAR(10),CampAttrUn.EffectiveEndDateTime,101)		AS ValidTo					
				,Cmp.Amount														AS AmountOff
				,CASE WHEN C.RedeemCount <> 0 
					THEN 'Yes' 
					ELSE 'No' 
				END																AS IsRedeemed
				,Ccm.CustomerID													AS CustomerIDIsLinked
				,Cr.CustomerID													AS CustomerIDRedeemed		
				,CONVERT(VARCHAR(10),Cr.UTCCreatedDateTime,101)					AS RedemptionDate					
				,CampAttrUn.SubscriptionPlanID		
				,Cmp.CampaignTypeID
				,CampAttrUn.LapsePeriod
				,Cmp.DescriptionShort											AS InternalDescription
				,Cmp.DescriptionLong											AS ExternalDescription
				,CampAttrUn.MaxRedemption
				,C.RedeemCount													AS CouponRedeemedHowManyTimes
			FROM  CampAttrUn WITH (NOLOCK)
				INNER JOIN Coupon.Coupon C (NOLOCK)
					ON CampAttrUn.CouponID = C.CouponID
				INNER JOIN Coupon.Campaign Cmp (NOLOCK)
					ON Cmp.CampaignID = CampAttrUn.CampaignID
				LEFT OUTER JOIN Coupon.CouponCustomerMap Ccm (NOLOCK)
					ON Ccm.CouponID = C.CouponID
				LEFT OUTER JOIN Coupon.CouponRedemption Cr (NOLOCK)
					ON Cr.CouponCode = C.CouponCode
			ORDER BY RedemptionDate DESC
			
	END
ELSE -- Search to go ahead with CustomerID
	BEGIN
	
	;With CRTemp
	AS
	(SELECT CampaignID,C.CouponCode,CustomerID,UTCCreatedDateTime FROM Coupon.CouponRedemption CR (NOLOCK)
		JOIN Coupon.Coupon C (NOLOCK)
		ON C.CouponCode=CR.CouponCode 
		AND CustomerID=@CustomerID
	 )
	 , CMTemp
	 AS
	 (
	 SELECT CampaignID,CM.CouponID,CustomerID FROM Coupon.CouponCustomerMap CM (NOLOCK)
		JOIN Coupon.Coupon C (NOLOCK)
		ON C.CouponID=CM.CouponID 
		WHERE CustomerID=@CustomerID
	)
	, CampAttr
		AS
		(SELECT PVT.CampaignId
				,PVT.[1] SubscriptionPlanId
				,CAST(SUBSTRING(PVT.[2],6,2)+'/'+SUBSTRING(PVT.[2],9,2)+'/'+SUBSTRING(PVT.[2],1,4) AS VARCHAR(10)) EffectiveStartDateTime
				,CAST(SUBSTRING(PVT.[3],6,2)+'/'+SUBSTRING(PVT.[3],9,2)+'/'+SUBSTRING(PVT.[3],1,4) AS VARCHAR(10)) EffectiveEndDateTime
				,PVT.[4] MaxRedemption
				,PVT.[5] LapsePeriod
				,PVT.[6] CouponsGeneratedCount
			FROM
				(
				SELECT C.CampaignId,
						AttributeValue,
						AttributeID			
				FROM  (SELECT CampaignID FROM CRTemp WITH (NOLOCK)
						UNION
						SELECT CampaignID FROM CMTemp WITH (NOLOCK)) CT
				JOIN Coupon.Campaign C (NOLOCK)
					ON C.CampaignID=CT.CampaignID	
			   JOIN Coupon.CampaignAttributes CA (NOLOCK)
					ON CA.CampaignID = C.CampaignID
				) TempA
				PIVOT (
					 MIN(Attributevalue)
					 FOR AttributeID in ([1],[2],[3],[4],[5],[6])
				) PVT
		)
		SELECT	C.CouponID													
				,C.CouponCode
				,Cmp.CampaignID
				,Cmp.CampaignCode
				,CONVERT(VARCHAR(10),CampAttr.EffectiveStartDateTime,101)		AS ValidFrom
				,CONVERT(VARCHAR(10),CampAttr.EffectiveEndDateTime,101)			AS ValidTo					
				,Cmp.Amount														AS AmountOff
				,CASE WHEN C.RedeemCount <> 0 
					THEN 'Yes' 
					ELSE 'No' 
				END																AS IsRedeemed
				,Ccm.CustomerID													AS CustomerIDIsLinked
				,Cr.CustomerID													AS CustomerIDRedeemed		
				,CONVERT(VARCHAR(10),Cr.UTCCreatedDateTime,101)					AS RedemptionDate					
				,CampAttr.SubscriptionPlanID		
				,Cmp.CampaignTypeID
				,CampAttr.LapsePeriod
				,Cmp.DescriptionShort											AS InternalDescription
				,Cmp.DescriptionLong											AS ExternalDescription
				,CampAttr.MaxRedemption
				,C.RedeemCount													AS CouponRedeemedHowManyTimes
				FROM  CampAttr  WITH (NOLOCK)
				INNER JOIN Coupon.Campaign Cmp (NOLOCK)
					ON Cmp.CampaignID = CampAttr.CampaignID
				INNER JOIN Coupon.Coupon C (NOLOCK)
					ON Cmp.CampaignID = C.CampaignID
				LEFT OUTER JOIN CMTemp Ccm (NOLOCK)
					ON Ccm.CouponID = C.CouponID
				LEFT OUTER JOIN CRTemp Cr (NOLOCK)
					ON Cr.CouponCode = C.CouponCode
		WHERE ( Ccm.CustomerID = @CustomerID OR  Cr.CustomerID = @CustomerID )
		ORDER BY RedemptionDate DESC	
	END
END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[SearchCoupon] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupon]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupon] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[SearchCoupon] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[SearchCoupons]

		IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupons] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[SearchCoupons] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [Coupon].[SearchCoupons] 
(
@CampaignID BIGINT = NULL
,@PageCount INT
,@PageSize INT
)
AS
/*  
    Author:			Robin
	Date created:	25 Apr 2014
	Purpose:		To get Campaign Details Based on CampaignID
	Behaviour:		
	Usage:			Often/Hourly
	Called by:		Juvo
	WarmUP Script:	Execute [Coupon].[SearchCoupons]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/
 

BEGIN
DECLARE
       @Size      INT

IF @PageSize = -1 

BEGIN
     SET @Size = (Select Count(1) From Coupon.Coupon) 
	 SET @PageCount=1 
END
			
ELSE 
     SET @Size = @PageSize 



	 SELECT TOP (@Size) *  FROM(			
			SELECT ROW_NUMBER() OVER (ORDER BY TempT.[CouponID] DESC
											)
							AS RowNumber
			, TempT.*
	   FROM(SELECT CC.CouponID,
	 CC.CouponCode,
	 CA.DescriptionLong,
	 CCM.CustomerID
	 From Coupon.Coupon CC WITH (NOLOCK) INNER JOIN Coupon.Campaign CA WITH (NOLOCK)
	 ON CC.CampaignID=CA.CampaignID
	 LEFT OUTER JOIN Coupon.CouponCustomerMap CCM
	 ON CC.CouponID=CCM.CouponID
	 where CC.CampaignID=@CampaignID	
	)TempT	
	)Temp	
	WHERE   RowNumber > (@PageCount - 1)*@Size
			ORDER BY RowNumber


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[SearchCoupons] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupons] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[SearchCoupons] not created.',16,1)
	END
GO

USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[UnredeemedCouponGet]

		IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[UnredeemedCouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[UnredeemedCouponGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[UnredeemedCouponGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[UnredeemedCouponGet]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : Coupon(s) which aren't redeemed
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[UnredeemedCouponGet] 
(
@CampaignID				BIGINT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @CampaignTypeID			INT
	
BEGIN TRY

	SELECT @CampaignTypeID = C.CampaignTypeID 
	FROM
		Coupon.Campaign C
	WHERE C.CampaignID = @CampaignID 
	
	IF (@@ROWCOUNT  = 0)
		BEGIN
			SET @ErrorMessage = 'Unable to Determine CampaignTypeID for the supplied CampaignID'
					
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
	ELSE
		BEGIN		
			SELECT 
				C.CouponCode, 
				CCM.CustomerID 
			FROM Coupon.Coupon C (NOLOCK)  
				INNER JOIN Coupon.CouponCustomerMap CCM (NOLOCK)
				ON C.CouponID = CCM.CouponID
			WHERE C.CampaignID = @CampaignID 
			AND NOT EXISTS (SELECT 1 FROM Coupon.CouponRedemption Cr (NOLOCK)
							WHERE C.CouponCode = Cr.CouponCode) 								
	END
	
	END TRY
	BEGIN CATCH
	SET @ErrorMessage = ERROR_MESSAGE()
	
	IF OBJECT_ID('tempdb..#CustomerLinkedCoupons') IS NOT NULL DROP TABLE #CustomerLinkedCoupons									
		
			RAISERROR (
					'SP - [coupon].[UnredeemedCouponGet] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)			
	END CATCH
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[UnredeemedCouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[UnredeemedCouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[UnredeemedCouponGet] not created.',16,1)
	END
GO
	

CREATE PROCEDURE [dbo].[pxshGASHistoryDeliverySaver]      
(      
@branchlist  varchar(2000)= null      
)      
      
AS      
    
SELECT  CASE   
  WHEN SubscriptionPlanID = 1 THEN '3 Month Plan'    
  WHEN SubscriptionPlanID = 2 THEN '6 Month Plan'   
  WHEN SubscriptionPlanID = 5 THEN '3 Month Midweek Plan'   
  WHEN SubscriptionPlanID = 6 THEN '6 Month Midweek Plan'   
  END as software,    
    convert(char(11),CustomerPlanStartDate, 112) as orderdate,    
      datepart(hh, CustomerPlanStartDate) as orderhour,count(*) as orders    
 FROM [tescosubscription].[CustomerSubscription] (nolock)    
Where [SubscriptionStatus] = 8    
and CustomerPlanStartDate between dateadd(dd, -15, getdate()) and getdate()    
and SwitchCustomerSubscriptionID IS NULL
group by    
  SubscriptionPlanID, convert(char(11),CustomerPlanStartDate, 112) ,datepart(hh, CustomerPlanStartDate)
  order by software DESC, orderdate, orderhour      
        
        
GO
IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE [dbo].[pxshGASHistoryDeliverySaver2]

		IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [dbo].[pxshGASHistoryDeliverySaver2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [dbo].[pxshGASHistoryDeliverySaver2] not dropped.',16,1)
			END
	END
GO

/*
Author:  Peter, Hall    
Created: 2012/11    
Purpose: Get Delivery Saver subscription sign up history information for GAS  

--Modifications History--    
Changed On   Changed By  	Defect  Changes  Change Description     
19/07/2013   Deepmala, Trivedi	N/A     Extened to include 4 new additional plans
					3 Month Anytime Plan - Pay Monthly, 6 Month Anytime Plan - Pay Monthly,   
					3 Month Midweek Plan - Pay Monthly & 6 Month Midweek Plan - Pay Monthly
*/   

CREATE PROCEDURE [dbo].[pxshGASHistoryDeliverySaver2]      
(      
@branchlist  varchar(2000)= null      
)           
AS      
    
SELECT  CASE   
  WHEN SubscriptionPlanID = 1 THEN '3 Month Anytime Plan - Pay Upfront'    
  WHEN SubscriptionPlanID = 2 THEN '6 Month Anytime Plan - Pay Upfront'   
  WHEN SubscriptionPlanID = 5 THEN '3 Month Midweek Plan - Pay Upfront'   
  WHEN SubscriptionPlanID = 6 THEN '6 Month Midweek Plan - Pay Upfront' 
  WHEN SubscriptionPlanID = 7 THEN '3 Month Anytime Plan - Pay Monthly'
  WHEN SubscriptionPlanID = 8 THEN '6 Month Anytime Plan - Pay Monthly'   
  WHEN SubscriptionPlanID = 9 THEN '3 Month Midweek Plan - Pay Monthly'
  WHEN SubscriptionPlanID = 10 THEN '6 Month Midweek Plan - Pay Monthly'
  END as software,    
    convert(char(11),CustomerPlanStartDate, 112) as orderdate,    
      datepart(hh, CustomerPlanStartDate) as orderhour,count(*) as orders    
 FROM [tescosubscription].[CustomerSubscription] (nolock)    
Where [SubscriptionStatus] = 8    
and CustomerPlanStartDate between dateadd(dd, -15, getdate()) and getdate()    
and SwitchCustomerSubscriptionID IS NULL
group by    
  SubscriptionPlanID, convert(char(11),CustomerPlanStartDate, 112) ,datepart(hh, CustomerPlanStartDate)
  order by software DESC, orderdate, orderhour      
        
        
GO

GRANT EXECUTE ON [dbo].[pxshGASHistoryDeliverySaver2] TO [hs_central_supp]

IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [dbo].[pxshGASHistoryDeliverySaver2] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [dbo].[pxshGASHistoryDeliverySaver2] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignCodeGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCodeGetAll]

		IF OBJECT_ID(N'[Coupon].[CampaignCodeGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCodeGetAll] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCodeGetAll] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignCodeGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignCodeGetAll]
** DATE WRITTEN   : 27/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignCodeGetAll] 

AS

BEGIN

SET NOCOUNT ON;
DECLARE @ErrorMessage		NVARCHAR(2048)

BEGIN TRY

	SELECT CampaignCode from Coupon.Campaign
			
END TRY	
BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()

		RAISERROR (
				'SP - [coupon].[CampaignCodeGetAll] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
END CATCH

END
GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignCodeGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignCodeGetAll]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignCodeGetAll] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignCodeGetAll] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCountGetAll]

		IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCountGetAll] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCountGetAll] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignCountGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignCountGetAll]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE Coupon.CampaignCountGetAll
AS

BEGIN

	SELECT COUNT(CampaignID) AS CampaignCount FROM Coupon.Campaign

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignCountGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignCountGetAll] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignCountGetAll] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCouponGet]

		IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCouponGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignCouponGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignCouponGet]
** DATE WRITTEN   : 25/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignCouponGet] 
(
@CampaignID				BIGINT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @CampaignTypeID			INT
	
BEGIN TRY

	SELECT @CampaignTypeID = C.CampaignTypeID 
	FROM
		Coupon.Campaign C
	WHERE C.CampaignID = @CampaignID 
	
	IF (@@ROWCOUNT  = 0)
		BEGIN
			SET @ErrorMessage = 'Unable to Determine CampaignTypeID for the supplied CampaignID'
					
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
	ELSE
		BEGIN
			IF (@CampaignTypeID = 1 OR @CampaignTypeID = 2)--Naive or Unique Coupons
				BEGIN

					SELECT Cpn.CouponCode
						FROM Coupon.Coupon Cpn
						WHERE Cpn.CampaignID = @CampaignID
					
				END
			ELSE IF(@CampaignTypeID = 3)
				BEGIN
					--Getting the list of CustomerID with linked Coupon Code
					SELECT Cm.CustomerID
							,Cpn.CouponCode
						FROM Coupon.Coupon Cpn
						INNER JOIN Coupon.CouponCustomerMap Cm
							ON Cm.CouponID = Cpn.CouponID
							AND Cpn.CampaignID = @CampaignID

				END
			END
		END TRY
		BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
				
				RAISERROR (
						'SP - [coupon].[CampaignCouponGet] Error = (%s)',
						16,
						1,
						@ErrorMessage
						)			
		END CATCH
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignCouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignCouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignCouponGet] not created.',16,1)
	END
GO
	

USE [TescoSubscription]
GO
/****** Object:  StoredProcedure [Coupon].[CampaignDetailsGetAll]    Script Date: 06/12/2013 07:14:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsGetAll]

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetAll] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignDetailsGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[CampaignDetailsGetAll]
** DATE WRITTEN   : 06/04/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): DATA OF TABLE [Coupon].[CampaignDetailsGetAll] WHICH IS ACTIVE
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	20 Jun 2013		Navdeep_Singh	131642			Modified Decimal Conversion parameters - 'Cost Associated'
	02 Jul 2013		Navdeep_Singh	NA				Development: Changed to incorporate req. for View Coupon Story
	04 Jul 2013		Navdeep_Singh	NA				Development: Changed to include CampaignTypeID and ExternalDescription for View Coupon Story
*/

CREATE PROCEDURE [Coupon].[CampaignDetailsGetAll] 
(
@CampaignID BIGINT = NULL
)
AS

BEGIN
SET NOCOUNT ON

DECLARE @ErrorMessage    NVARCHAR(2048)

BEGIN TRY
			IF (@CampaignID IS NULL)
			BEGIN
				SET @CampaignID = 0
			END
			
			SELECT 	TempCampaignDetails.CampaignID
					,TempCampaignDetails.UTCCreatedDateTime
					,TempCampaignDetails.CampaignCode
					,TempCampaignDetails.CampaignTypeName
					,TempCampaignDetails.CampaignTypeID
					,TempCampaignAttributes.SubscriptionPlanId 
					,ISNULL(TempCampaignDetails.DescriptionShort,'') AS [InternalDescription]
					,ISNULL(TempCampaignDetails.DescriptionLong,'') AS [ExternalDescription]			
					,TempCampaignAttributes.[CouponsGeneratedCount]
					,ISNULL(TempCouponDetails.[Redemptions],0) AS [Redemptions]
					,ISNULL(TempCampaignDetails.[AmountOff],0)	AS [AmountOff]		
					,ISNULL(CONVERT(DECIMAL(38,2),(TempCouponDetails.[Redemptions] * [AmountOff])),0) AS [CostAssociated]
					,TempCampaignDetails.IsActive
					,TempCampaignAttributes.EffectiveStartDateTime
					,TempCampaignAttributes.EffectiveEndDateTime 
					,TempCampaignAttributes.MaxRedemption
					,TempCampaignAttributes.LapsePeriod	
			FROM
				(
				SELECT	C.CampaignID
						,C.UTCCreatedDateTime
						,CampaignCode
						,C.CampaignTypeID
						,CTM.CampaignTypeName
						,C.DescriptionShort
						,C.DescriptionLong
						,C.Amount AS [AmountOff]
						,C.IsActive												
				 FROM Coupon.Campaign C (NOLOCK)
				INNER JOIN Coupon.CampaignTypeMaster CTM (NOLOCK)
					On C.CampaignTypeID = CTM.CampaignTypeID		
				)TempCampaignDetails
				LEFT OUTER JOIN (SELECT	Cpn.CampaignID
										,Sum (Cpn.RedeemCount) AS [Redemptions]								
								FROM Coupon.Coupon Cpn						
								GROUP BY CampaignID
								)TempCouponDetails
				ON TempCampaignDetails.CampaignID = TempCouponDetails.CampaignID
				LEFT OUTER JOIN (
								SELECT PVT.CampaignId
										,PVT.[1] SubscriptionPlanId
										,PVT.[2] EffectiveStartDateTime
										,PVT.[3] EffectiveEndDateTime
										,PVT.[4] MaxRedemption
										,PVT.[5] LapsePeriod
										,PVT.[6] CouponsGeneratedCount 
								FROM
									(
									SELECT C.CampaignId,
											AttributeValue,
											AttributeID			
									FROM Coupon.Campaign C 
									JOIN Coupon.CampaignAttributes CA
										ON ca.CampaignID = c.CampaignID			
									) A
									PIVOT (
										 MIN(Attributevalue)
										 FOR AttributeID in ([1],[2],[3],[4],[5],[6])
									) PVT
								)TempCampaignAttributes
									ON TempCampaignAttributes.CampaignID=TempCampaignDetails.CampaignID		
						WHERE @CampaignID = 0 OR TempCampaignDetails.CampaignID = @CampaignID
						ORDER BY TempCampaignDetails.UTCCreatedDateTime DESC,TempCampaignDetails.CampaignID DESC
		END TRY

		BEGIN CATCH
				SET @ErrorMessage = ERROR_MESSAGE()	
			
				RAISERROR (
				'SP - [Coupon].[CampaignDetailsGetAll] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
		END CATCH;
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetAll] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll1]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CampaignDetailsGetAll1]
    
    IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll1]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll1] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CampaignDetailsGetAll1] not dropped.',
            16,
            1
        )
    END
END

GO

CREATE PROCEDURE [Coupon].[CampaignDetailsGetAll1] 
(
@CampaignID NVARCHAR(300) = NULL
)
AS

/*
	Author:		Robin
	Created:	17/March/2014
	Purpose:	Get Campaign Details
    Called By:  Coupon Service

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
SET NOCOUNT ON

DECLARE
@ErrorMessage    NVARCHAR(2048)
,@Delimiter    NVARCHAR(1)
,@String       NVARCHAR(25)

SET @Delimiter = ','

DECLARE 
@CouponTable  TABLE (String NVARCHAR(44))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CampaignID,@Delimiter))


BEGIN TRY
			IF (@CampaignID IS NULL)
			BEGIN
				SET @CampaignID = 0
			END
			
			SELECT 	TempCampaignDetails.CampaignID
					,TempCampaignDetails.UTCCreatedDateTime
					,TempCampaignDetails.CampaignCode
					,TempCampaignDetails.CampaignTypeName
					,TempCampaignDetails.CampaignTypeID
					,ISNULL(TempCampaignDetails.DescriptionShort,'') AS [InternalDescription]
					,ISNULL(TempCampaignDetails.DescriptionLong,'') AS [ExternalDescription]			
					,TempCampaignAttributes.[CouponsGeneratedCount]
					,ISNULL(TempCouponDetails.[Redemptions],0) AS [Redemptions]
					,ISNULL(CONVERT(DECIMAL(38,2),(TempCouponDetails.[Redemptions] * [AmountOff])),0) AS [CostAssociated]
					,TempCampaignDetails.IsActive
					,TempCampaignAttributes.EffectiveStartDateTime
					,TempCampaignAttributes.EffectiveEndDateTime 
					,TempCampaignAttributes.MaxRedemption
					,TempCampaignAttributes.LapsePeriod	
                    ,TempCampaignAttributes.CouponsGeneratedCount 
                    ,TempCampaignAttributes.IsClubCardBoost
                    ,TempCampaignAttributes.ClubCardVoucherValue
                    ,TempCampaignDetails.UsageTypeID
                    ,TempCampaignDetails.IsMutuallyExclusive
                    ,TempCampaignDetails.UsageName
			FROM
				(
				SELECT	C.CampaignID
						,C.UTCCreatedDateTime
						,CampaignCode
						,C.CampaignTypeID
						,CTM.CampaignTypeName
						,C.DescriptionShort
						,C.DescriptionLong
                        ,C.Amount AS [AmountOff]
						,C.IsActive	
                        ,C.UsageTypeID
                        ,C.IsMutuallyExclusive
                        ,UT.UsageName
                FROM Coupon.Campaign C (NOLOCK)
				INNER JOIN Coupon.CampaignTypeMaster CTM (NOLOCK)
					On C.CampaignTypeID = CTM.CampaignTypeID
                INNER JOIN Coupon.CouponUsageType UT
                    ON C.UsageTypeID = UT.UsageTypeID	
				)TempCampaignDetails
				LEFT OUTER JOIN (SELECT	Cpn.CampaignID
										,Sum (Cpn.RedeemCount) AS [Redemptions]								
								FROM Coupon.Coupon Cpn						
								GROUP BY CampaignID
								)TempCouponDetails
				ON TempCampaignDetails.CampaignID = TempCouponDetails.CampaignID
				LEFT OUTER JOIN (
								SELECT PVT.CampaignId
										,PVT.[2] EffectiveStartDateTime
										,PVT.[3] EffectiveEndDateTime
										,PVT.[4] MaxRedemption
										,PVT.[5] LapsePeriod
										,PVT.[6] CouponsGeneratedCount 
                                        ,PVT.[7] IsClubCardBoost
                                        ,PVT.[8] ClubCardVoucherValue
								FROM
									(
									SELECT C.CampaignId,
											AttributeValue,
											AttributeID			
									FROM Coupon.Campaign C 
									JOIN Coupon.CampaignAttributes CA
										ON ca.CampaignID = c.CampaignID			
									) A
									PIVOT (
										 MIN(Attributevalue)
										 FOR AttributeID in ([2],[3],[4],[5],[6],[7],[8])
									) PVT
								)TempCampaignAttributes
									ON TempCampaignAttributes.CampaignID=TempCampaignDetails.CampaignID		
						WHERE @CampaignID IN (Select String FROM @CouponTable) OR TempCampaignDetails.CampaignID IN (Select String FROM @CouponTable)
						ORDER BY TempCampaignDetails.UTCCreatedDateTime DESC,TempCampaignDetails.CampaignID DESC

SELECT DT.CampaignID
,DT.DiscountTypeID
,DT.DiscountValue 
,TM.DiscountName
FROM Coupon.CampaignDiscountType DT WITH (NOLOCK)
INNER JOIN Coupon.DiscountTypeMaster TM  WITH (NOLOCK)
ON DT.DiscountTypeID = TM.DiscountTypeID
WHERE DT.CampaignID IN (Select String FROM @CouponTable)

SELECT CampaignID
,SubscriptionPlanID
From Coupon.CampaignPlanDetails WITH(NOLOCK)
WHERE CampaignID IN (Select String FROM @CouponTable)


		END TRY

		BEGIN CATCH
				SET @ErrorMessage = ERROR_MESSAGE()	
			
				RAISERROR (
				'SP - [Coupon].[CampaignDetailsGetAll] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
		END CATCH;
END
 
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsGetAll1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll1]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll1] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CampaignDetailsGetAll1] not created.',
        16,
        1
    )
END
GO




USE [TescoSubscription]
GO
/****** Object:  StoredProcedure [Coupon].[CampaignDetailsGetPage]    Script Date: 06/12/2013 07:14:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsGetPage]

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetPage] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetPage] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignDetailsGetPage]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[CampaignDetailsGetPage]
** DATE WRITTEN   : 12 July 2013
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): DATA OF TABLE [Coupon].[CampaignDetailsGetPage] WHICH IS ACTIVE
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
*/

CREATE PROCEDURE [Coupon].[CampaignDetailsGetPage] 
(
@Start		INT
,@PageSize	INT
)
AS

BEGIN
SET NOCOUNT ON

DECLARE @ErrorMessage    NVARCHAR(2048)

BEGIN TRY


		;WITH TempCampaignAttributes
		AS
		(
			SELECT PVT.CampaignId
				,PVT.[1] SubscriptionPlanId
				,PVT.[2] EffectiveStartDateTime
				,PVT.[3] EffectiveEndDateTime
				,PVT.[4] MaxRedemption
				,PVT.[5] LapsePeriod
				,PVT.[6] CouponsGeneratedCount 
			FROM
			(
			SELECT C.CampaignId,
					AttributeValue,
					AttributeID			
			FROM Coupon.Campaign C 
			JOIN Coupon.CampaignAttributes CA
				ON ca.CampaignID = c.CampaignID			
			) A
			PIVOT (
				 MIN(Attributevalue)
				 FOR AttributeID in ([1],[2],[3],[4],[5],[6])
			) PVT
		)
		
		SELECT * FROM(			
		SELECT ROW_NUMBER() OVER (ORDER BY TempT.UTCCreatedDateTime DESC
										,TempT.CampaignID DESC)
						AS RowNumber
				, TempT.*
			FROM(
			SELECT 	TempCampaignDetails.CampaignID
					,TempCampaignDetails.UTCCreatedDateTime
					,TempCampaignDetails.CampaignCode
					,TempCampaignDetails.CampaignTypeName
					,TempCampaignDetails.CampaignTypeID
					,TempCampaignAttributes.SubscriptionPlanId 
					,ISNULL(TempCampaignDetails.DescriptionShort,'') AS [InternalDescription]
					,ISNULL(TempCampaignDetails.DescriptionLong,'') AS [ExternalDescription]			
					,TempCampaignAttributes.[CouponsGeneratedCount]
					,ISNULL(TempCouponDetails.[Redemptions],0) AS [Redemptions]
					,ISNULL(TempCampaignDetails.[AmountOff],0)	AS [AmountOff]		
					,ISNULL(CONVERT(DECIMAL(38,2),(TempCouponDetails.[Redemptions] * [AmountOff])),0) AS [CostAssociated]
					,TempCampaignDetails.IsActive
					,TempCampaignAttributes.EffectiveStartDateTime
					,TempCampaignAttributes.EffectiveEndDateTime 
					,TempCampaignAttributes.MaxRedemption
					,TempCampaignAttributes.LapsePeriod	
			FROM
				(
				SELECT	C.CampaignID
						,C.UTCCreatedDateTime
						,CampaignCode
						,C.CampaignTypeID
						,CTM.CampaignTypeName
						,C.DescriptionShort
						,C.DescriptionLong
						,C.Amount AS [AmountOff]
						,C.IsActive												
				 FROM Coupon.Campaign C (NOLOCK)
				INNER JOIN Coupon.CampaignTypeMaster CTM (NOLOCK)
					ON C.CampaignTypeID = CTM.CampaignTypeID		
				)TempCampaignDetails
				LEFT OUTER JOIN (SELECT	Cpn.CampaignID
										,Sum (Cpn.RedeemCount) AS [Redemptions]								
								FROM Coupon.Coupon Cpn						
								GROUP BY CampaignID
								)TempCouponDetails
				ON TempCampaignDetails.CampaignID = TempCouponDetails.CampaignID
				INNER JOIN TempCampaignAttributes --Only those records will come for which campaign attributes exists
					ON TempCampaignAttributes.CampaignID=TempCampaignDetails.CampaignID				
				)TempT
			)Temp
			WHERE RowNumber BETWEEN (@Start+1) AND (@Start+@PageSize)
			ORDER BY RowNumber
			
			
		END TRY

		BEGIN CATCH
				SET @ErrorMessage = ERROR_MESSAGE()	
		
				RAISERROR (
				'SP - [Coupon].[CampaignDetailsGetPage] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
		END CATCH;
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsGetPage] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetPage] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetPage] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage1]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CampaignDetailsGetPage1]
    
    IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage1]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetPage1] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CampaignDetailsGetPage1] not dropped.',
            16,
            1
        )
    END
END

GO
CREATE PROCEDURE [Coupon].[CampaignDetailsGetPage1] 
(
	 @StartDate DATETIME
	,@EndDate   DATETIME
	,@CampaignCode NVARCHAR(25)
	,@CampaignDiscription NVARCHAR(200)
	,@SubscriptionPlan NVARCHAR(50)
	,@Filtervalue INT
	,@PageOffset INT
	,@PageSize INT
)
AS
/*

	Author:			Deepmala
	Date created:	22/02/2013
	Purpose:		Returns All Coupon Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		BOA
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
   
*/
BEGIN
SET NOCOUNT ON
	

DECLARE 
    @CurrentDate DATETIME 
   ,@ErrorMessage  NVARCHAR(2048)
   ,@PlanData VARCHAR(100)
   ,@PageStart INT
   ,@PageEnd INT

SELECT @CurrentDate  = CONVERT(VARCHAR(10),GETDATE(),101)
      ,@PageStart = (@PageSize * (@PageOffset - 1)) + 1
      ,@PageEnd = (@PageOffset * @PageSize)

BEGIN TRY
	CREATE TABLE #TmpSearchData(CampaignId BIGINT,EffectiveStartDateTime DATETIME,EffectiveEndDateTime DATETIME,
				CouponsGeneratedCount VARCHAR(100),UTCCreatedDateTime DATETIME,CampaignCode VARCHAR(50),
				InternalDescription VARCHAR(300), CampaignTypeName VARCHAR(100), UsageName VARCHAR(100),IsActive BIT,
				Redemptions INT, AmountDiscount NUMERIC(10,2),PercentageDiscount INT ,CCDiscount INT,CostAssociated VARCHAR(100))
	
	CREATE TABLE #FinalData(CampaignId BIGINT,EffectiveStartDateTime DATETIME,EffectiveEndDateTime DATETIME,
				CouponsGeneratedCount VARCHAR(100),UTCCreatedDateTime DATETIME,CampaignCode VARCHAR(50),
				InternalDescription VARCHAR(300), CampaignTypeName VARCHAR(100), UsageName VARCHAR(100),IsActive BIT,
				Redemptions INT, AmountDiscount NUMERIC(10,2),PercentageDiscount INT,CCDiscount INT,
				CostAssociated VARCHAR(100), RNo INT)
			
	CREATE TABLE #CC (CampaignId BIGINT)--Hold the campaignids after filter on CampaignCode or CouponCode 
	CREATE TABLE #PlanTable (PlanId NVARCHAR(25))

		IF(LEN(@SubscriptionPlan)>0)
		BEGIN
			INSERT INTO #PlanTable ([PlanId]) SELECT Item FROM dbo.ConvertListToTable(@SubscriptionPlan,',')
		END

		IF (len(IsNull(@CampaignCode,''))>5)
		BEGIN
			INSERT INTO #CC SELECT CC.CampaignId FROM coupon.campaign CC					
			JOIN Coupon.Coupon CO ON CO.CampaignId = CC.CampaignId WHERE (CouponCode like '%'+ @CampaignCode + '%') 					
		END
		ELSE 

		BEGIN
			INSERT INTO #CC SELECT CC.CampaignId FROM coupon.campaign CC								
			WHERE (CampaignCode like '%'+ @CampaignCode + '%' OR @CampaignCode IS NULL) 					
		END

		;WITH TempCampaignAttributes AS
		( SELECT PVT.CampaignId,CONVERT(DATETIME,PVT.[2],101) EffectiveStartDateTime
				,CONVERT(DATETIME,PVT.[3],101) EffectiveEndDateTime	,CONVERT(INT,PVT.[6]) CouponsGeneratedCount
				,PVT.UTCCreatedDateTime,PVT.CampaignCode,PVT.InternalDescription,PVT.CampaignTypeName,PVT.UsageName,
				PVT.IsActive
			FROM
				(
					Select CC.CampaignId,CC.UTCCreatedDateTime ,CampaignCode,CC.DescriptionShort as InternalDescription,CampaignTypeName,
					UsageName,CC.IsActive, AttributeValue,AttributeId			
					From coupon.campaign CC					
					INNER JOIN Coupon.CampaignTypeMaster CT ON CC.CampaignTypeId = CT.CampaignTypeId
					INNER JOIN Coupon.CouponUsageType CU ON CC.UsageTypeId = CU.UsageTypeId
					INNER JOIN Coupon.CampaignAttributes CA ON ca.CampaignID = Cc.CampaignID	
					INNER JOIN #CC ON #CC.CampaignId = CC.CampaignId 				
					WHERE 						
					((CC.DescriptionShort like '%'+ @CampaignDiscription + '%' OR @CampaignDiscription IS NULL) 
					OR (CC.DescriptionLong like '%'+ @CampaignDiscription + '%' OR @CampaignDiscription IS NULL))				
				) A
					PIVOT (MIN(Attributevalue) FOR AttributeID in ([2],[3],[6])
				) PVT 			
		)

		Select * INTO #Mydata From TempCampaignAttributes
		
		--select * from #Mydata
		SELECT	CPN.CampaignID ,SUM (Cpn.RedeemCount) AS [Redemptions] INTO #RemData
        FROM Coupon.Coupon Cpn		
		JOIN #Mydata ON #Mydata.CampaignId = CPN.CampaignID				
        GROUP BY CPN.CampaignID 
		
		--Discounts calculation (Value column in UI)
		SELECT [1] AS AmountDiscount,[2] AS PercentageDiscount,[3]AS CCDiscount,CampaignId INTO #DiscountsData
		From 
			(
				SELECT DiscountTypeId,DiscountValue,CD.CampaignId FROM Coupon.CampaignDiscountType CD
				JOIN #Mydata ON #Mydata.CampaignId = CD.CampaignID	
			)A
			PIVOT(MIN(DiscountValue) FOR DiscountTypeId in ([1],[2],[3])
		)B
		--select * from #DiscountsData

		--Cost Associated  : Start
		SELECT CO.campaignid,CAST(SUM(PaymentAmount) AS NUMERIC(10,2)) AS CostAssociated INTO #TmpAmtData
		FROM tescosubscription.customerpaymenthistory CPH
		JOIN tescosubscription.customerpaymenthistoryresponse CPHR
        ON CPH.CustomerPaymentHistoryId = CPHR.CustomerPaymentHistoryId		
		JOIN tescosubscription.customerpayment CP 
        ON CP.CustomerPaymentId = CPH.CustomerPaymentId
		JOIN coupon.coupon CO 
        ON CO.CouponCode = CP.PaymentToken
		JOIN #Mydata 
        ON #Mydata.CampaignId = CO.CampaignID	
		WHERE paymentmodeid = 2
        AND PaymentStatusId = 1
		GROUP BY CO.campaignid

		SELECT CO.campaignid,COUNT(DISTINCT CustomerSubscriptionid) AS CSCount INTO #TmpCCData 
		FROM tescosubscription.customerpaymenthistory CPH
		JOIN tescosubscription.customerpaymenthistoryresponse CPHR
        ON CPH.CustomerPaymentHistoryId = CPHR.CustomerPaymentHistoryId
		JOIN tescosubscription.customerpayment CP 
        ON CP.CustomerPaymentId = CPH.CustomerPaymentId
		JOIN coupon.coupon CO 
        ON CO.CouponCode = CP.PaymentToken
		JOIN coupon.campaignDIscountType CDT 
        ON CDT.CampaignId = CO.CampaignId
		JOIN #Mydata 
        ON #Mydata.CampaignId = CO.CampaignID	
		WHERE paymentmodeid = 2 AND PaymentStatusId = 1 AND CDT.DiscountTypeId = 3
		GROUP BY CO.campaignid,CustomerSubscriptionid

		SELECT TC.CampaignId,CAST(SUM(CSCount * DiscountValue) AS INT) AS CCPointsDiscount 
		INTO #TmpFInalCcData FROM #TmpCCData TC 
		JOIN coupon.campaignDIscountType CD
        ON CD.CampaignId = TC.CampaignId 
		WHERE discounttypeid = 3
		GROUP BY TC.CampaignId
		
		SELECT #TmpAmtData.CampaignId,
			(CASE WHEN ISNULL(CostAssociated,0)>0 then ('œ' + CONVERT(VARCHAR,CostAssociated)) ELSE '' END) + 
			(CASE WHEN (ISNULL(CostAssociated,0)>0 and isnull(CCPointsDiscount,0)>0) THEN ', ' ELSE '' END) + 
			(CASE WHEN ISNULL(CCPointsDiscount,0)>0 THEN (CONVERT(VARCHAR,CCPointsDiscount) + ' CC POINTS') ELSE '' END 
			
			)
			AS CostAssociated			
		INTO #TmpFinalCostData
		FROM #TmpAmtData
		LEFT join #TmpFInalCcData on #TmpAmtData.Campaignid = #TmpFInalCcData.campaignid
		--Calculation end
		
		;WITH CampaignSearch AS (SELECT MyData.CampaignId,MyData.EffectiveStartDateTime,MyData.EffectiveEndDateTime				
				,MyData.CouponsGeneratedCount,MyData.UTCCreatedDateTime,MyData.CampaignCode,MyData.InternalDescription,
				MyData.CampaignTypeName,MyData.UsageName,MyData.IsActive
				,#RemData.Redemptions,AmountDiscount,PercentageDiscount,CCDiscount,#TmpFinalCostData.CostAssociated				
				FROM  #Mydata MyData
				INNER JOIN #RemData ON #RemData.CampaignId = Mydata.CampaignId
				INNER JOIN #DiscountsData ON #DiscountsData.CampaignId = Mydata.CampaignId
				LEFT OUTER JOIN #TmpFinalCostData ON #TmpFinalCostData.CampaignId = Mydata.CampaignId
					)
			
		SELECT * INTO #Mydata1 FROM CampaignSearch 
		--select * from #Mydata1
		IF ((Select count(*) from #PlanTable)>0)
		BEGIN	
			--Filter unique campaignids for plan search to avoid multiple records for one campaign with multiple plans
			SELECT distinct TC.CampaignId INTO #CampaignsPlan FROM #Mydata1 TC
			JOIN Coupon.CampaignPlanDetails CP ON CP.CampaignId = TC.CampaignId
			JOIN #PlanTable P ON P.PlanId = CP.SubscriptionPlanId
			
			INSERT INTO #TmpSearchData (CampaignId,EffectiveStartDateTime,EffectiveEndDateTime,
				CouponsGeneratedCount,UTCCreatedDateTime,CampaignCode,
				InternalDescription, CampaignTypeName ,UsageName,IsActive,
				Redemptions, AmountDiscount,PercentageDiscount,CCDiscount,CostAssociated)
			SELECT TC.CampaignId,EffectiveStartDateTime,EffectiveEndDateTime,CouponsGeneratedCount,
				TC.UTCCreatedDateTime,CampaignCode,InternalDescription,CampaignTypeName,UsageName,IsActive,Redemptions,
				AmountDiscount,PercentageDiscount,CCDiscount,CostAssociated
			FROM #Mydata1 TC
			JOIN #CampaignsPlan CP ON CP.CampaignId = TC.CampaignId
			
		END

		ELSE

		BEGIN
			INSERT INTO #TmpSearchData SELECT * FROM #Mydata1
		END		
		
		If ISNULL(@Filtervalue,0) = 1 --Active Campaign
		Begin
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber FROM #TmpSearchData
				WHERE CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(VARCHAR,GETDATE(),101) and
				CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(VARCHAR,GETDATE(),101) and IsActive = 1
				AND (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL)
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101) OR @StartDate IS NULL)
			)

			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		End
		Else If ISNULL(@Filtervalue,0) = 2 --Future Campaign
		Begin
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber FROM #TmpSearchData
				WHERE CONVERT(DATETIME,EffectiveStartDateTime,101) > CONVERT(VARCHAR,GETDATE(),101) and IsActive = 1
				AND (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL)
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101) OR @StartDate IS NULL)
			)
						
			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		End
		Else If ISNULL(@Filtervalue,0) = 3  --Past Campaign
		Begin
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber
				 FROM #TmpSearchData
				Where CONVERT(DATETIME,EffectiveEndDateTime,101) < CONVERT(VARCHAR,GETDATE(),101) --and IsActive = 0
				AND (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL)
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101) OR @StartDate IS NULL)
			)
						
			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		End
		Else If ISNULL(@Filtervalue,0) = 4 --Stopped Campaign
		Begin
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber FROM #TmpSearchData Where IsActive = 0
				AND (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL) 
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101)OR @StartDate IS NULL)
				)		
			
			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		END
		ELSE
		BEGIN	
			;WITH CampaignSearch AS (SELECT *,ROW_NUMBER() OVER(ORDER BY UTCCreatedDateTime DESC
				,#TmpSearchData.CampaignID DESC) AS RowNumber FROM #TmpSearchData
				WHERE (CONVERT(DATETIME,EffectiveStartDateTime,101) <= CONVERT(DATETIME,@EndDate,101) OR @EndDate IS NULL) 
				AND (CONVERT(DATETIME,EffectiveEndDateTime,101) >= CONVERT(DATETIME,@StartDate,101)OR @StartDate IS NULL)
			)
			
			INSERT INTO #FinalData SELECT * FROM CampaignSearch 
		END

		SELECT * FROM #FinalData WHERE RNo BETWEEN @PageStart and @PageEnd
		SELECT COUNT(CampaignId) as TotalRecords FROM #FinalData
END TRY

BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()	

		RAISERROR (
		'SP - [Coupon].[CampaignDetailsGetPage1] Error = (%s)',
		16,
		1,
		@ErrorMessage
		)
END CATCH;

END
 
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsGetPage1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetPage1]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetPage1] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CampaignDetailsGetPage1] not created.',
        16,
        1
    )
END
GO



 
 



USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsSave]

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsSave] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignDetailsSave]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignDetailsSave]
** DATE WRITTEN   : 25/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignDetailsSave] 
(
@XmlDocument XML
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @XmlDocumentHandle		INT
	DECLARE @NewCampaignId			BIGINT	
	DECLARE @SaveIdnFlag			VARCHAR(50)
	DECLARE @ProcSection			VARCHAR(100)
	DECLARE @CampaignTypeID			INT 

	BEGIN TRY

	SET @ProcSection = 'Section Reading XML'
	-- Create an internal representation of the XML document.
	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @XmlDocument


	SELECT CampaignID
			,CampaignCode
			,DescriptionShort
			,DescriptionLong
			,Amount
			,CASE WHEN IsActive like 'true'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignTypeId
			,GetUTCDate() AS UTCCreatedeDateTime
			,GetUTCDate() AS UTCUpdatedDateTime
	INTO #TempCampaignDetails		
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, '/Campaign',1)
		WITH (	CampaignID			BIGINT,				--check on this
				CampaignCode		NVARCHAR(25),
				DescriptionShort	NVARCHAR(200),
				DescriptionLong		NVARCHAR(300),
				Amount				MONEY,
				IsActive			VARCHAR(5),
				CampaignTypeId int
			  )
		  )TempCampaign
		  
	IF EXISTS (SELECT 1 FROM #TempCampaignDetails WHERE LEN(CampaignCode) = 0)
	BEGIN
		SET @ErrorMessage = 'Invalid Coupon Code is being transmitted. Please check.'
		
		RAISERROR (
				'%s',
				16,
				1,
				@ErrorMessage
			)
	END
	
	SELECT @CampaignTypeId = CampaignTypeId FROM  #TempCampaignDetails
	
	IF (@CampaignTypeId = 3) --Linked Coupon(s) need to be generated
		BEGIN
			SELECT CustomerID
					,CouponCode
					--,DescriptionShort
					--,DescriptionLong
					,Amount
					,RedeemCount
					,CASE WHEN IsActive like 'True'
						THEN 1
						ELSE
						0
					END AS IsActive
					,CampaignID
					,GetUTCDate() AS UTCCreatedeDateTime
					,GetUTCDate() AS UTCUpdatedDateTime
			INTO #TempLinkedCouponDetails
			FROM(
			SELECT *
			FROM OPENXML (@XmlDocumentHandle, '/Campaign/CouponsList/CouponDetail',1)
			WITH (	CustomerID			bigint,
					CouponCode			nvarchar(25),
					--DescriptionShort	nvarchar(200),
					--DescriptionLong		nvarchar(300),
					Amount				Money,
					RedeemCount			int,
					IsActive			varchar(5),
					CampaignID			bigint
				  )
				  )TempCoupon
		END
	ELSE
		BEGIN	     
			--Coupons Details 
			SELECT  CouponCode
					--,DescriptionShort
					--,DescriptionLong
					,Amount
					,RedeemCount
					,CASE WHEN IsActive like 'True'
						THEN 1
						ELSE
						0
					END AS IsActive
					,CampaignID
					,GetUTCDate() AS UTCCreatedeDateTime
					,GetUTCDate() AS UTCUpdatedDateTime
			INTO #TempCouponDetails
			FROM(
				SELECT *
				FROM OPENXML (@XmlDocumentHandle, '/Campaign/CouponsList/CouponDetail',1)
				WITH (	CouponCode			NVARCHAR(25),
						--DescriptionShort	NVARCHAR(200),
						--DescriptionLong		NVARCHAR(300),
						Amount				MONEY,
						RedeemCount			INT,
						IsActive			VARCHAR(5),
						CampaignID			BIGINT
					  )
				  )TempCoupon
		END     

	--Attribute Details 
	SELECT TempAttributes.*
			,GETUTCDATE() AS [UTCCreatedDateTime]
			,GETUTCDATE() AS [UTCUpdatedDateTime]
	INTO #TempCampaignAttributes
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignAttributesList/CampaignAttribute',3)
		WITH (AttributeID		SMALLINT,
			  AttributeValue	NVARCHAR(50)
			  )
		)TempAttributes
	ORDER BY TempAttributes.AttributeId 

	EXEC sp_xml_removedocument @XmlDocumentHandle

	END TRY

	BEGIN CATCH
		SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
		
		RAISERROR (
				'SP - [coupon].[CampaignDetailsSave] Error = (%s)',
				16,
				1,
				@ErrorMessage
			)
	END CATCH


	BEGIN TRY
	
	BEGIN TRANSACTION [Save_CampaignDetails] 

	IF (@CampaignTypeId >=1 AND @CampaignTypeId <=3) --Saving Campaign Details and Naive or Unique Coupon(s)
	BEGIN
			SET @ProcSection = 'Section in Coupon.Campaign:'
			
			INSERT INTO [TescoSubscription].[Coupon].[Campaign]
					   ([CampaignCode]
					   ,[DescriptionShort]
					   ,[DescriptionLong]
					   ,[Amount]
					   ,[IsActive]
					   ,[CampaignTypeId]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
				SELECT CampaignCode
						,DescriptionShort
						,DescriptionLong
						,Amount
						,IsActive
						,CampaignTypeId
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
				FROM #TempCampaignDetails		
				
			SELECT @NewCampaignId = @@IDENTITY
					
			PRINT 'New CampaignID Generated: ' + Convert(Varchar(200),@NewCampaignId) --remove this line in final code of proc
			
			SET @ProcSection = 'Section in Coupon.Coupon: '
			
			IF (@CampaignTypeId >=1 AND @CampaignTypeId <=2)
			BEGIN
			--PRINT 'INSERTING NAIVE OR UNIQUE COUPONS'
			INSERT INTO [TescoSubscription].[Coupon].[Coupon]
					   ([CouponCode]
					   --,[DescriptionShort]
					   --,[DescriptionLong]
					   ,[Amount]
					   ,[RedeemCount]
					   ,[IsActive]
					   ,[UTCCreatedeDateTime]
					   ,[UTCUpdatedDateTime]
					   ,[CampaignID])
				SELECT CouponCode
						--,DescriptionShort
						--,DescriptionLong
						,Amount
						,RedeemCount
						,IsActive					
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
						,@NewCampaignId
				FROM #TempCouponDetails
			END
			
			IF (@CampaignTypeId = 3) --Customer Linked Coupons
			BEGIN
				--PRINT 'INSERTING LINKED COUPONS'
				INSERT INTO [TescoSubscription].[Coupon].[Coupon]
					   ([CouponCode]
					   --,[DescriptionShort]
					   --,[DescriptionLong]
					   ,[Amount]
					   ,[RedeemCount]
					   ,[IsActive]
					   ,[UTCCreatedeDateTime]
					   ,[UTCUpdatedDateTime]
					   ,[CampaignID])
				SELECT CouponCode
						--,DescriptionShort
						--,DescriptionLong
						,Amount
						,RedeemCount
						,IsActive					
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
						,@NewCampaignId
				FROM #TempLinkedCouponDetails
			END
				
			SET @ProcSection = 'Section Coupon.CampaignAttributes: '
							
			INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
					   ([CampaignID]
					   ,[AttributeID]
					   ,[AttributeValue]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
				SELECT @NewCampaignId
						,AttributeID
						,AttributeValue
						,UTCCreatedDateTime
						,UTCUpdatedDateTime
				FROM #TempCampaignAttributes		
				
				
		END
			
	IF (@CampaignTypeId = 3)
		BEGIN		
			SET @ProcSection = 'Section Coupon.CouponCustomerMap: '
				
			INSERT INTO [TescoSubscription].[Coupon].[CouponCustomerMap]
			   ([CouponID]
			   ,[CustomerID]
			   ,[UTCCreatedDateTime]
			   ,[UTCUpdatedDateTime])
			Select Cpn.CouponID
				,Tcd.CustomerID
				,GetUTCDate() AS [UTCCreatedDateTime]
				,GetUTCDate() AS [UTCUpdatedDateTime]
			FROM #TempLinkedCouponDetails Tcd
			INNER JOIN Coupon.Coupon Cpn
				ON Lower(Tcd.CouponCode) = Lower(Cpn.CouponCode)					
		END
		
	IF (@CampaignTypeId < 1 OR @CampaignTypeId > 3)
		BEGIN
			SET @ErrorMessage = 'Unrecognised CampaignType supplied in XML '
			
			IF @@TRANCOUNT > 0
					BEGIN
						ROLLBACK TRANSACTION [Save_CampaignDetails]
					END
			
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
		
		COMMIT TRANSACTION [Save_CampaignDetails]		
				
	--Removing Temporary Table(S)
	
	DROP TABLE #TempCampaignDetails
	
	IF (@CampaignTypeId <> 3)
	BEGIN
		DROP TABLE #TempCouponDetails
	END
	ELSE
	BEGIN
		DROP TABLE #TempLinkedCouponDetails
	END
	
	DROP TABLE #TempCampaignAttributes

	--Selecting the new Campaign ID generated in String Format as per UI req.
	SELECT CONVERT(VARCHAR(100),@NewCampaignId)				
	PRINT 'CAMPAIGN AND COUPON(S) SUCCESSFULLY SAVED IN DATABASE.'		
		
	END TRY	
	BEGIN CATCH
			SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
	
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [Save_CampaignDetails]
			END
			
			RAISERROR (
					'SP - [coupon].[CampaignDetailsSave] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)
	END CATCH

END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsSave] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsSave1]

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsSave1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsSave1] not dropped.',16,1)
			END
	END
GO
CREATE PROCEDURE [Coupon].[CampaignDetailsSave1] 
(
@XmlDocument XML
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @XmlDocumentHandle		INT
	DECLARE @NewCampaignId			BIGINT	
	DECLARE @SaveIdnFlag			VARCHAR(50)
	DECLARE @ProcSection			VARCHAR(100)
	DECLARE @CampaignTypeID			INT 
	DECLARE @UsageType				INT

	BEGIN TRY

	SET @ProcSection = 'Section Reading XML'
	-- Create an internal representation of the XML document.
	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @XmlDocument


	SELECT CampaignID
			,CampaignCode
			,DescriptionShort
			,DescriptionLong
			,Amount
			,CASE WHEN IsActive like 'true'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignTypeId
			,IsMutuallyExclusive
			,UsageTypeID
			,GetUTCDate() AS UTCCreatedeDateTime
			,GetUTCDate() AS UTCUpdatedDateTime
	INTO #TempCampaignDetails		
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign',2)
		WITH (	CampaignID			BIGINT,				--check on this
				CampaignCode		NVARCHAR(25),
				DescriptionShort	NVARCHAR(200),
				DescriptionLong		NVARCHAR(300),
				Amount				MONEY,
				IsActive			VARCHAR(5),
				CampaignTypeId		INT,
				IsMutuallyExclusive	BIT,
				UsageTypeId         TINYINT './UsageType/UsageTypeId'
			  )
		  )TempCampaign
		  
	IF EXISTS (SELECT 1 FROM #TempCampaignDetails WHERE LEN(CampaignCode) = 0)
	BEGIN
		SET @ErrorMessage = 'Invalid Coupon Code is being transmitted. Please check.'
		
		RAISERROR (
				'%s',
				16,
				1,
				@ErrorMessage
			)
	END
	
 --Adding PlanIDs to temp table
	SELECT 
			*
	INTO #TempPlanID		
	FROM (			
		SELECT *
FROM   OPENXML(@XmlDocumentHandle, 'Campaign/SubscriptionPlanIds/string', 2)
       WITH ([PlanID] INT '.')
		  )TempPlans

 --Adding Discount types
SELECT 
			*
	INTO #TempDiscountTypes
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignDiscounts/DiscountType',2)
		WITH (	DiscountTypeId			TINYINT,
				DiscountTypeValue       DECIMAL(6,2)				--check on this
			  )
		  )TempDiscounts


	SELECT @CampaignTypeId = CampaignTypeId FROM  #TempCampaignDetails
	
	IF (@CampaignTypeId = 3) --Linked Coupon(s) need to be generated
		BEGIN
			SELECT CustomerID
					,CouponCode
					--,DescriptionShort
					--,DescriptionLong
					,Amount
					,RedeemCount
					,CASE WHEN IsActive like 'True'
						THEN 1
						ELSE
						0
					END AS IsActive
					,CampaignID
					,GetUTCDate() AS UTCCreatedeDateTime
					,GetUTCDate() AS UTCUpdatedDateTime
			INTO #TempLinkedCouponDetails
			FROM(
			SELECT *
			FROM OPENXML (@XmlDocumentHandle, 'Campaign/Coupons/Coupon',2)
			WITH (	CustomerID			bigint 'CustomerIds/string',
					CouponCode			nvarchar(25) './CouponCode',
					--DescriptionShort	nvarchar(200),
					--DescriptionLong		nvarchar(300),
					Amount				Money,
					RedeemCount			int,
					IsActive			varchar(5),
					CampaignID			bigint
				  )
				  )TempCoupon
		END
	ELSE
		BEGIN	     
			--Coupons Details 
			SELECT  CouponCode
					--,DescriptionShort
					--,DescriptionLong
					,Amount
					,RedeemCount
					,CASE WHEN IsActive like 'True'
						THEN 1
						ELSE
						0
					END AS IsActive
					,CampaignID
					,GetUTCDate() AS UTCCreatedeDateTime
					,GetUTCDate() AS UTCUpdatedDateTime
			INTO #TempCouponDetails
			FROM(
				SELECT *
				FROM OPENXML (@XmlDocumentHandle, 'Campaign/Coupons/Coupon',2)
				WITH (	CouponCode			NVARCHAR(25),
						--DescriptionShort	NVARCHAR(200),
						--DescriptionLong		NVARCHAR(300),
						Amount				MONEY,
						RedeemCount			INT,
						IsActive			VARCHAR(5),
						CampaignID			BIGINT
					  )
				  )TempCoupon
		END     

	--Attribute Details 
	SELECT TempAttributes.*
			,GETUTCDATE() AS [UTCCreatedDateTime]
			,GETUTCDATE() AS [UTCUpdatedDateTime]
	INTO #TempCampaignAttributes
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignAttributes/CampaignAttribute',3)
		WITH (AttributeID		SMALLINT,
			  AttributeValue	NVARCHAR(50)
			  ) where AttributeID > 0
		)TempAttributes
	ORDER BY TempAttributes.AttributeId 

	EXEC sp_xml_removedocument @XmlDocumentHandle

	END TRY

	BEGIN CATCH
		SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
		
		RAISERROR (
				'SP - [coupon].[CampaignDetailsSave] Error = (%s)',
				16,
				1,
				@ErrorMessage
			)
	END CATCH


	BEGIN TRY
	
	BEGIN TRANSACTION [Save_CampaignDetails] 

	IF (@CampaignTypeId >=1 AND @CampaignTypeId <=3) --Saving Campaign Details and Naive or Unique Coupon(s)
	BEGIN
			SET @ProcSection = 'Section in Coupon.Campaign:'
			
			INSERT INTO [TescoSubscription].[Coupon].[Campaign]
					   ([CampaignCode]
					   ,[DescriptionShort]
					   ,[DescriptionLong]
					   ,[Amount]
					   ,[IsActive]
					   ,[CampaignTypeId]
					   ,IsMutuallyExclusive	
					   ,UsageTypeID	
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
				SELECT CampaignCode
						,DescriptionShort
						,DescriptionLong
						,0
						,IsActive
						,CampaignTypeId
						,IsMutuallyExclusive	
					    ,UsageTypeId	
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
				FROM #TempCampaignDetails		
				
			SELECT @NewCampaignId = @@IDENTITY
					
			--PRINT 'New CampaignID Generated: ' + Convert(Varchar(200),@NewCampaignId) --remove this line in final code of proc
			
			SET @ProcSection = 'Section in Coupon.Coupon: '
			
			IF (@CampaignTypeId >=1 AND @CampaignTypeId <=2)
			BEGIN
			--PRINT 'INSERTING NAIVE OR UNIQUE COUPONS'
			INSERT INTO [TescoSubscription].[Coupon].[Coupon]
					   ([CouponCode]
					   --,[DescriptionShort]
					   --,[DescriptionLong]
					   ,[Amount]
					   ,[RedeemCount]
					   ,[IsActive]
					   ,[UTCCreatedeDateTime]
					   ,[UTCUpdatedDateTime]
					   ,[CampaignID])
				SELECT CouponCode
						--,DescriptionShort
						--,DescriptionLong
						,0
						,RedeemCount
						,IsActive					
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
						,@NewCampaignId
				FROM #TempCouponDetails
			END
			
			IF (@CampaignTypeId = 3) --Customer Linked Coupons
			BEGIN
				--PRINT 'INSERTING LINKED COUPONS'
				INSERT INTO [TescoSubscription].[Coupon].[Coupon]
					   ([CouponCode]
					   --,[DescriptionShort]
					   --,[DescriptionLong]
					   ,[Amount]
					   ,[RedeemCount]
					   ,[IsActive]
					   ,[UTCCreatedeDateTime]
					   ,[UTCUpdatedDateTime]
					   ,[CampaignID])
				SELECT CouponCode
						--,DescriptionShort
						--,DescriptionLong
						,0
						,RedeemCount
						,IsActive					
						,UTCCreatedeDateTime
						,UTCUpdatedDateTime
						,@NewCampaignId
				FROM #TempLinkedCouponDetails
			END
				
			SET @ProcSection = 'Section Coupon.CampaignAttributes: '
							
			INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
					   ([CampaignID]
					   ,[AttributeID]
					   ,[AttributeValue]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
				SELECT @NewCampaignId
						,AttributeID
						,AttributeValue
						,UTCCreatedDateTime
						,UTCUpdatedDateTime
				FROM #TempCampaignAttributes		
				
				
		END
			
	IF (@CampaignTypeId = 3)
		BEGIN		
			SET @ProcSection = 'Section Coupon.CouponCustomerMap: '
				
			INSERT INTO [TescoSubscription].[Coupon].[CouponCustomerMap]
			   ([CouponID]
			   ,[CustomerID]
			   ,[UTCCreatedDateTime]
			   ,[UTCUpdatedDateTime])
			Select Cpn.CouponID
				,Tcd.CustomerID
				,GetUTCDate() AS [UTCCreatedDateTime]
				,GetUTCDate() AS [UTCUpdatedDateTime]
			FROM #TempLinkedCouponDetails Tcd
			INNER JOIN Coupon.Coupon Cpn
				ON Lower(Tcd.CouponCode) = Lower(Cpn.CouponCode)					
		END
		
      INSERT INTO Coupon.CampaignDiscountType
		(CampaignID
		,DiscountTypeID
		,DiscountValue
		,[UTCCreatedDateTime]
		,[UTCUpdatedDateTime])
		
		Select 
		@NewCampaignId
		,DiscountTypeId
		,DiscountTypeValue
		,GetUTCDate() AS [UTCCreatedDateTime]
		,GetUTCDate() AS [UTCUpdatedDateTime]
		 FROM #TempDiscountTypes 
		
	INSERT INTO Coupon.CampaignPlanDetails
		(CampaignID
		 ,SubscriptionPlanID
		 ,UTCCreatedDateTime
		 ,UTCUpdatedDateTime)
		SELECT 
		  @NewCampaignId
		 ,PlanID
		 ,GetUTCDate() AS [UTCCreatedDateTime]
		 ,GetUTCDate() AS [UTCUpdatedDateTime]
         FROM #TempPlanID

	IF (@CampaignTypeId < 1 OR @CampaignTypeId > 3)
		BEGIN
			SET @ErrorMessage = 'Unrecognised CampaignType supplied in XML '
			
			IF @@TRANCOUNT > 0
					BEGIN
						ROLLBACK TRANSACTION [Save_CampaignDetails]
					END
			
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
		
		COMMIT TRANSACTION [Save_CampaignDetails]		
				
	--Removing Temporary Table(S)
	
	DROP TABLE #TempCampaignDetails
	
	IF (@CampaignTypeId <> 3)
	BEGIN
		DROP TABLE #TempCouponDetails
	END
	ELSE
	BEGIN
		DROP TABLE #TempLinkedCouponDetails
	END
	
	DROP TABLE #TempCampaignAttributes
	DROP TABLE #TempDiscountTypes
	DROP TABLE #TempPlanID
	--Selecting the new Campaign ID generated in String Format as per UI req.
	SELECT CONVERT(VARCHAR(100),@NewCampaignId)				
	PRINT 'CAMPAIGN AND COUPON(S) SUCCESSFULLY SAVED IN DATABASE.'		
		
	END TRY	
	BEGIN CATCH
			SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
	
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [Save_CampaignDetails]
			END
			
			RAISERROR (
					'SP - [coupon].[CampaignDetailsSave1] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)
	END CATCH

END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignDetailsSave1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignDetailsSave1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsSave1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsSave1] not created.',16,1)
	END
GO






USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignEdit]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignEdit]

		IF OBJECT_ID(N'[Coupon].[CampaignEdit]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignEdit] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignEdit]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignEdit]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignEdit] 
(
@XmlDocument XML
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @XmlDocumentHandle		INT
	DECLARE @CampaignID				BIGINT
	DECLARE @RecordsToAdd			BIGINT
	DECLARE @RecordsToDelete		BIGINT
	DECLARE @RecordsToDeleteCoup	BIGINT
	DECLARE @ProcSection			VARCHAR(100)
	DECLARE @CampaignTypeID			INT
	

	BEGIN TRY

	SET @ProcSection = 'Section Reading XML'
	-- Create an internal representation of the XML document.
	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @XmlDocument


	SELECT CampaignID
			,CampaignCode
			,DescriptionShort
			,DescriptionLong
			,Amount
			,CASE WHEN IsActive like 'true'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignTypeId
			,GetUTCDate() AS UTCUpdatedDateTime
	INTO #TempCampaignDetails		
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, '/Campaign',1)
		WITH (	CampaignID			BIGINT,				--check on this
				CampaignCode		NVARCHAR(25),
				DescriptionShort	NVARCHAR(200),
				DescriptionLong		NVARCHAR(300),
				Amount				MONEY,
				IsActive			VARCHAR(5),
				CampaignTypeId int
			  )
		  )TempCampaign
		  
	IF EXISTS (SELECT 1 FROM #TempCampaignDetails WHERE LEN(CampaignCode) = 0)
	BEGIN
		SET @ErrorMessage = 'Invalid Coupon Code is being transmitted. Please check.'
		
		RAISERROR (
				'%s',
				16,
				1,
				@ErrorMessage
			)
	END
	
	SELECT @CampaignID = CampaignID,
			@CampaignTypeId = CampaignTypeId 
	FROM  #TempCampaignDetails
	
	SELECT CustomerID
			,CouponCode
			,Amount
			,RedeemCount
			,CASE WHEN IsActive like 'True'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CASE WHEN IsRedeemed like 'True'
				THEN 1
				ELSE
				0
			END AS IsRedeemed
			,CampaignID
			,ActionFlag				
	INTO #TempLinkedCouponDetails
	FROM(
	SELECT *
	FROM OPENXML (@XmlDocumentHandle, '/Campaign/CouponsList/CouponDetail',1)
	WITH (	CustomerID			BIGINT,
			CouponCode			NVARCHAR(25),
			Amount				MONEY,
			RedeemCount			INT,
			IsActive			VARCHAR(5),
			IsRedeemed			VARCHAR(5),
			CampaignID			BIGINT,
			ActionFlag			VARCHAR(10)
		  )
		)TempCoupon
				  
	SELECT @RecordsToAdd = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 1 --Getting records to insert
	
	SELECT @RecordsToDelete = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 0 --Getting records to delete
	
	SELECT @RecordsToDeleteCoup = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 0 AND IsRedeemed = 0 -- Getting coupons to delete
	
	--Attribute Details 
	SELECT TempAttributes.*						
	INTO #TempCampaignAttributes
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignAttributesList/CampaignAttribute',3)
		WITH (AttributeID		SMALLINT,
			  AttributeValue	NVARCHAR(50)
			  )
		)TempAttributes
	ORDER BY TempAttributes.AttributeId 

	EXEC sp_xml_removedocument @XmlDocumentHandle


	BEGIN TRANSACTION [Save_CampaignDetails] 

	IF (@CampaignTypeId >=1 AND @CampaignTypeId <=3) --Editing Campaign Details for all Coupon(s)
	BEGIN
		
			SET @ProcSection = 'Update Section in Coupon.Campaign:'
				
			UPDATE [TescoSubscription].[Coupon].[Campaign]
					SET	CampaignCode = TCD.CampaignCode
						,DescriptionShort = TCD.DescriptionShort
						,DescriptionLong = TCD.DescriptionLong
						,Amount = TCD.Amount
						,IsActive = TCD.IsActive
						,CampaignTypeId = TCD.CampaignTypeId						
						,UTCUpdatedDateTime = GETUTCDATE()
					FROM #TempCampaignDetails TCD
					INNER JOIN [TescoSubscription].[Coupon].[Campaign] C
						ON C.CampaignID = TCD.CampaignID			
						
			IF(@@ROWCOUNT <> 1)
			BEGIN			
				SET @ErrorMessage = 'Failed in ' + @ProcSection
				
				RAISERROR (
							'%s',
							16,
							1,
							@ErrorMessage
							)
			END
			
			SET @ProcSection = 'Update Section Coupon.CampaignAttributes: '			
			
			UPDATE [TescoSubscription].[Coupon].[CampaignAttributes]
				SET	AttributeValue = TCA.AttributeValue,
					UTCUpdatedDateTime = GETUTCDATE()
				FROM #TempCampaignAttributes TCA
				INNER JOIN Coupon.CampaignAttributes CA
					   ON  CA.CampaignID = @CampaignID
					   AND CA.AttributeId = TCA.AttributeId	
					
			IF(@@ROWCOUNT <> 6)
			BEGIN			
				SET @ErrorMessage = 'Failed in ' + @ProcSection
				
				RAISERROR (
							'%s',
							16,
							1,
							@ErrorMessage
							)
			END		
			
				
			IF (@RecordsToAdd <> 0)
			BEGIN
			
			/*ADD SECTION BEGINS */
			
				SET @ProcSection = 'Add Section in Coupon.Coupon: '
					
					
					INSERT INTO [TescoSubscription].[Coupon].[Coupon]
						   ([CouponCode]
						   ,[Amount]
						   ,[RedeemCount]
						   ,[IsActive]
						   ,[UTCCreatedeDateTime]
						   ,[UTCUpdatedDateTime]
						   ,[CampaignID])
					SELECT CouponCode
							,Amount
							,RedeemCount
							,IsActive					
							,GetUTCDate() AS [UTCCreatedeDateTime]
							,GetUTCDate() AS [UTCUpdatedDateTime]
							,CampaignId
					FROM #TempLinkedCouponDetails TCD
					WHERE Tcd.IsActive = 1
						
					IF(@@ROWCOUNT <> @RecordsToAdd)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END		
				
					SET @ProcSection = 'Add Section Coupon.CouponCustomerMap: '
					
					INSERT INTO [TescoSubscription].[Coupon].[CouponCustomerMap]
					   ([CouponID]
					   ,[CustomerID]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
					Select Cpn.CouponID
							,Tcd.CustomerID
							,GetUTCDate() AS [UTCCreatedDateTime]
							,GetUTCDate() AS [UTCUpdatedDateTime]
					FROM #TempLinkedCouponDetails Tcd
					INNER JOIN Coupon.Coupon Cpn
						ON LOWER(Tcd.CouponCode) = LOWER(Cpn.CouponCode)
						AND Tcd.IsActive = 1
												
					IF(@@ROWCOUNT <> @RecordsToAdd)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END	
			END			
						
		/*ADD SECTION ENDS*/

		/*DELETE SECTION BEGINS*/			
			IF (@RecordsToDelete <> 0)
			BEGIN
				SET @ProcSection = 'Delete Section Coupon.CouponCustomerMap: '
				
				DELETE FROM [TescoSubscription].[Coupon].[CouponCustomerMap] 
				WHERE CouponID IN (
									SELECT Cpn.CouponID														
									FROM #TempLinkedCouponDetails Tcd
									INNER JOIN Coupon.Coupon Cpn
										ON Lower(Tcd.CouponCode) = Lower(Cpn.CouponCode)
										AND Tcd.IsActive = 0										
										)
					
				IF(@@ROWCOUNT <> @RecordsToDelete)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END	
					
				
				SET @ProcSection = 'Delete Section Coupon.Coupon: '					 
				
				DELETE FROM [TescoSubscription].[Coupon].[Coupon] 
				WHERE CouponCode IN (SELECT TCD.CouponCode 
										FROM #TempLinkedCouponDetails Tcd
											WHERE Tcd.IsActive = 0
											AND Tcd.IsRedeemed = 0
											)
					
					
				IF(@@ROWCOUNT <> @RecordsToDeleteCoup)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END				
					
			END		
		/*DELETE SECTION ENDS*/	
		
		COMMIT TRANSACTION [Save_CampaignDetails]
						
		END
	
		IF (@CampaignTypeId < 1 OR @CampaignTypeId > 3)
			BEGIN
				SET @ErrorMessage = 'Unrecognised CampaignType supplied in XML '
				
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION [Save_CampaignDetails]
				END
				
				RAISERROR (
						'%s',
						16,
						1,
						@ErrorMessage
						)
			END		
					
		--Removing Temporary Table(S)
		
		DROP TABLE #TempCampaignDetails
		
		DROP TABLE #TempLinkedCouponDetails
			
		DROP TABLE #TempCampaignAttributes
				
		PRINT 'CAMPAIGN AND COUPON(S) EDITED IN DATABASE FOR ' + CONVERT(NVARCHAR(100),@CampaignID) + ' CampaignID'
		
	END TRY	
	
	BEGIN CATCH
			SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
	
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [Save_CampaignDetails]
			END

			IF OBJECT_ID('tempdb..#TempCampaignDetails') IS NOT NULL DROP TABLE #TempCampaignDetails
			IF OBJECT_ID('tempdb..#TempLinkedCouponDetails') IS NOT NULL DROP TABLE #TempLinkedCouponDetails
			IF OBJECT_ID('tempdb..#TempCampaignAttributes') IS NOT NULL DROP TABLE #TempCampaignAttributes
						
			RAISERROR (
					'SP - [coupon].[CampaignEdit] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)
	END CATCH

END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignEdit] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignEdit]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignEdit] not created.',16,1)
	END
GOIF OBJECT_ID(N'[Coupon].[CampaignEdit1]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CampaignEdit1]
    
    IF OBJECT_ID(N'[Coupon].[CampaignEdit1]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit1] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CampaignEdit1] not dropped.',
            16,
            1
        )
    END
END

GO


CREATE PROCEDURE [Coupon].[CampaignEdit1] 
(
@XmlDocument XML
)
AS
/*   
 Author:   Saminathan
 Date created: 03 Apr 2014 
 Purpose:  Edits campaign Details
 Behaviour:  How does this procedure actually work  
 Usage:   Hourly/Often 
 Called by:  <SubscriptionService>  

  --Modifications History--  
 Changed On  Changed By  Defect Ref  Change Description  23/0
 
 */ 
BEGIN

	SET NOCOUNT ON

	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @XmlDocumentHandle		INT
	DECLARE @CampaignID				BIGINT
	DECLARE @RecordsToAdd			BIGINT
	DECLARE @RecordsToDelete		BIGINT
	--DECLARE @RecordsToDeleteCoup	BIGINT
	DECLARE @ProcSection			VARCHAR(100)
	DECLARE @CampaignTypeID			INT
	Declare @UsageTypeNew			INT
    Declare @UsageType			    INT
	Declare @ClubCardBoostFlagNew	BIT
    Declare @ClubCardBoostFlag      BIT
	BEGIN TRY

	SET @ProcSection = 'Section Reading XML'
	-- Create an internal representation of the XML document.
	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @XmlDocument


	SELECT CampaignID
			,CampaignCode
			,DescriptionShort
			,DescriptionLong
			,Amount
			,CASE WHEN IsActive like 'true'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignTypeId
			,IsMutuallyExclusive
			,UsageTypeID
			,GetUTCDate() AS UTCUpdatedDateTime
	INTO #TempCampaignDetails		
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign',2)
		WITH (	CampaignId		BIGINT 'CampaignId',				--check on this
				CampaignCode		NVARCHAR(25),
				DescriptionShort	NVARCHAR(200),
				DescriptionLong		NVARCHAR(300),
				Amount				MONEY,
				IsActive			VARCHAR(5),
				CampaignTypeId		int,
				IsMutuallyExclusive	BIT,
				UsageTypeId         TINYINT './UsageType/UsageTypeId'
			  )
		  )TempCampaign
		  
	IF EXISTS (SELECT 1 FROM #TempCampaignDetails WHERE LEN(CampaignCode) = 0)
	BEGIN
		SET @ErrorMessage = 'Invalid Coupon Code is being transmitted. Please check.'
		
		RAISERROR (
				'%s',
				16,
				1,
				@ErrorMessage
			)
	END
	
	SELECT @CampaignID = CampaignID,
			@CampaignTypeId = CampaignTypeId ,@UsageTypeNew=UsageTypeId
	FROM  #TempCampaignDetails
	
SELECT @UsageType=UsageTypeID from Coupon.Campaign where CampaignID=@CampaignID

	SELECT 
			*
	INTO #TempPlanID		
	FROM (			
		SELECT *
FROM   OPENXML(@XmlDocumentHandle, 'Campaign/SubscriptionPlanIds/string', 2)
       WITH ([PlanID] INT '.')
		  )TempPlans

SELECT 
			*
	INTO #TempDiscountTypes
	FROM (			
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignDiscounts/DiscountType',2)
		WITH (	DiscountTypeId			TINYINT,
				DiscountTypeValue       DECIMAL(6,2)				--check on this
			  )
		  )TempDiscounts
	

	SELECT CustomerID
			,CouponCode
			,Amount
			,RedeemCount
			,CASE WHEN IsActive like 'True'
				THEN 1
				ELSE
				0
			END AS IsActive
			,CampaignID
			,ActionFlag				
	INTO #TempLinkedCouponDetails
	FROM(
	SELECT *
	FROM OPENXML (@XmlDocumentHandle, 'Campaign/Coupons/Coupon',2)
	WITH (	CustomerID			BIGINT  'CustomerIds/string',
			CouponCode			NVARCHAR(25)   './CouponCode',
			Amount				MONEY,
			RedeemCount			INT,
			IsActive			VARCHAR(5),
			CampaignID			BIGINT,
			ActionFlag			VARCHAR(10)
		  )
		)TempCoupon
				  
	SELECT @RecordsToAdd = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 1 --Getting records to insert
	
	SELECT @RecordsToDelete = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 0 --Getting records to delete
	
	--SELECT @RecordsToDeleteCoup = Count(*) FROM #TempLinkedCouponDetails WHERE IsActive = 0 AND IsRedeemed = 0 -- Getting coupons to delete
	
	--Attribute Details 
	SELECT TempAttributes.*						
	INTO #TempCampaignAttributes
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'Campaign/CampaignAttributes/CampaignAttribute',3)
		WITH (AttributeID		SMALLINT,
			  AttributeValue	NVARCHAR(50)
			  )where AttributeID > 0
		)TempAttributes
	ORDER BY TempAttributes.AttributeId 

select @ClubCardBoostFlagNew=AttributeValue from #TempCampaignAttributes where AttributeID=7
select @ClubCardBoostFlag=AttributeValue from Coupon.CampaignAttributes where CampaignID=@CampaignID and  AttributeID=7 

	EXEC sp_xml_removedocument @XmlDocumentHandle


	BEGIN TRANSACTION [Save_CampaignDetails] 

	IF (@CampaignTypeId >=1 AND @CampaignTypeId <=3) --Editing Campaign Details for all Coupon(s)
	BEGIN
		
			SET @ProcSection = 'Update Section in Coupon.Campaign:'
				
			UPDATE [TescoSubscription].[Coupon].[Campaign]
					SET	CampaignCode = TCD.CampaignCode
						,DescriptionShort = TCD.DescriptionShort
						,DescriptionLong = TCD.DescriptionLong
						,Amount = 0
						,IsActive = TCD.IsActive
						--,CampaignTypeId = TCD.CampaignTypeId --campaigntypeid should not be allowed to change
						,IsMutuallyExclusive=TCD.IsMutuallyExclusive
						,UsageTypeID	=TCD.UsageTypeId				
						,UTCUpdatedDateTime = GETUTCDATE()
					FROM #TempCampaignDetails TCD
					INNER JOIN [TescoSubscription].[Coupon].[Campaign] C
						ON C.CampaignID = TCD.CampaignID			
						
			IF(@@ROWCOUNT <> 1)
			BEGIN			
				SET @ErrorMessage = 'Failed in ' + @ProcSection
				
				RAISERROR (
							'%s',
							16,
							1,
							@ErrorMessage
							)
			END
			
		SET @ProcSection = 'Update Section Coupon.CampaignPlanDetails: '	
		
		DELETE FROM Coupon.CampaignPlanDetails 
		WHERE CampaignID=@CampaignID 
		AND SubscriptionPlanID NOT IN (SELECT [PlanID] FROM #TempPlanID)

		INSERT INTO Coupon.CampaignPlanDetails  
		 (CampaignID
		,SubscriptionPlanID 
		,UTCCreatedDateTime
		,UTCUpdatedDateTime
		)
		SELECT 
		@CampaignID
		,PlanID
		,getutcdate()
		,getutcdate()
		 FROM #TempPlanID WHERE PlanID  NOT IN 
		(SELECT SubscriptionPlanID FROM Coupon.CampaignPlanDetails 
		WHERE CampaignId = @CampaignID) 

		SET @ProcSection = 'Update Section Coupon.CampaignDiscountType: '	
		
		DELETE FROM Coupon.CampaignDiscountType
        WHERE CampaignID = @CampaignID 
        AND DiscountTypeID NOT IN (SELECT DiscountTypeID FROM #TempDiscountTypes WHERE CampaignID = @CampaignID)
		
		UPDATE Coupon.CampaignDiscountType 
		SET DiscountValue=DiscountTypeValue,
			UTCUpdatedDateTime=GETUTCDATE()
		FROM #TempDiscountTypes TD INNER JOIN
		Coupon.CampaignDiscountType CD ON
		CD.CampaignID=@CampaignID
		AND CD.DiscountTypeID=TD.DiscountTypeId

		INSERT INTO [Coupon].[CampaignDiscountType] (
            CampaignID,
            DiscountTypeID,
            DiscountValue,
			UTCCreatedDateTime,
			UTCUpdatedDateTime
            )
            SELECT 
            @CampaignID,
            DiscountTypeID,
            DiscountTypeValue,
			getutcdate(),
			getutcdate()
            FROM #TempDiscountTypes 
            WHERE DiscountTypeID NOT IN 
			(SELECT DiscountTypeID FROM [Coupon].[CampaignDiscountType] WHERE CampaignID = @CampaignID)

			SET @ProcSection = 'Update Section Coupon.CampaignAttributes: '			
			
			UPDATE [TescoSubscription].[Coupon].[CampaignAttributes]
				SET	AttributeValue = TCA.AttributeValue,
					UTCUpdatedDateTime = GETUTCDATE()
				FROM #TempCampaignAttributes TCA
				INNER JOIN Coupon.CampaignAttributes CA
					   ON  CA.CampaignID = @CampaignID
					   AND CA.AttributeId = TCA.AttributeId	

			IF NOT (@UsageType = @UsageTypeNew)
				BEGIN
				 IF (@UsageTypeNew=1)
					BEGIN
					INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
									   ([CampaignID]
									   ,[AttributeID]
									   ,[AttributeValue]
									   ,[UTCCreatedDateTime]
									   ,[UTCUpdatedDateTime])
								SELECT @CampaignID
										,AttributeID
										,AttributeValue
										,GetUTCDate() AS [UTCCreatedeDateTime]
										,GetUTCDate() AS [UTCUpdatedDateTime]
								FROM #TempCampaignAttributes WHERE AttributeID=5
					END
				   ELSE IF(@UsageTypeNew=2)
						BEGIN
							DELETE FROM [TescoSubscription].[Coupon].[CampaignAttributes]
							WHERE CampaignID=@CampaignID and AttributeID=5			

						END

			END			

			IF NOT (@ClubCardBoostFlag = @ClubCardBoostFlagNew)
				BEGIN
				 IF (@ClubCardBoostFlagNew=1)
					BEGIN
					INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
									   ([CampaignID]
									   ,[AttributeID]
									   ,[AttributeValue]
									   ,[UTCCreatedDateTime]
									   ,[UTCUpdatedDateTime])
								SELECT @CampaignId
										,AttributeID
										,AttributeValue
										,GetUTCDate() AS [UTCCreatedeDateTime]
										,GetUTCDate() AS [UTCUpdatedDateTime]
								FROM #TempCampaignAttributes WHERE AttributeID=8
					END
				 ELSE IF(@ClubCardBoostFlagNew=0)
						BEGIN
							DELETE FROM [TescoSubscription].[Coupon].[CampaignAttributes]
							WHERE CampaignID=@CampaignID and AttributeID=8			

						END

			END		

		
				
			IF (@RecordsToAdd <> 0)
			BEGIN
			
			/*ADD SECTION BEGINS */
			
				SET @ProcSection = 'Add Section in Coupon.Coupon: '
					
					
					INSERT INTO [TescoSubscription].[Coupon].[Coupon]
						   ([CouponCode]
						   ,[Amount]
						   ,[RedeemCount]
						   ,[IsActive]
						   ,[UTCCreatedeDateTime]
						   ,[UTCUpdatedDateTime]
						   ,[CampaignID])
					SELECT CouponCode
							,0
							,RedeemCount
							,IsActive					
							,GetUTCDate() AS [UTCCreatedeDateTime]
							,GetUTCDate() AS [UTCUpdatedDateTime]
							,@CampaignID
					FROM #TempLinkedCouponDetails TCD
					WHERE Tcd.IsActive = 1
						
					IF(@@ROWCOUNT <> @RecordsToAdd)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END		
				
					SET @ProcSection = 'Add Section Coupon.CouponCustomerMap: '
					
					INSERT INTO [TescoSubscription].[Coupon].[CouponCustomerMap]
					   ([CouponID]
					   ,[CustomerID]
					   ,[UTCCreatedDateTime]
					   ,[UTCUpdatedDateTime])
					Select Cpn.CouponID
							,Tcd.CustomerID
							,GetUTCDate() AS [UTCCreatedDateTime]
							,GetUTCDate() AS [UTCUpdatedDateTime]
					FROM #TempLinkedCouponDetails Tcd
					INNER JOIN Coupon.Coupon Cpn
						ON LOWER(Tcd.CouponCode) = LOWER(Cpn.CouponCode)
						AND Tcd.IsActive = 1
												
					IF(@@ROWCOUNT <> @RecordsToAdd)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END	
			END			
						
		/*ADD SECTION ENDS*/
		
		

		/*DELETE SECTION BEGINS*/			
			IF (@RecordsToDelete <> 0)
			BEGIN
				SET @ProcSection = 'Delete Section Coupon.CouponCustomerMap: '
				
				DELETE FROM [TescoSubscription].[Coupon].[CouponCustomerMap] 
				WHERE CouponID IN (
									SELECT Cpn.CouponID														
									FROM #TempLinkedCouponDetails Tcd
									INNER JOIN Coupon.Coupon Cpn
										ON Lower(Tcd.CouponCode) = Lower(Cpn.CouponCode)
										AND Tcd.IsActive = 0										
										)
					
				IF(@@ROWCOUNT <> @RecordsToDelete)
					BEGIN			
						SET @ErrorMessage = 'Failed in ' + @ProcSection
						RAISERROR (
									'%s',
									16,
									1,
									@ErrorMessage
									)
					END	
					
				
				SET @ProcSection = 'Delete Section Coupon.Coupon: '					 
				
				DELETE FROM [TescoSubscription].[Coupon].[Coupon]  
				WHERE CouponCode IN (SELECT TCD.CouponCode 
										FROM #TempLinkedCouponDetails Tcd
											WHERE Tcd.IsActive = 0
											AND NOT EXISTS (SELECT 1 FROM Coupon.CouponRedemption Cr (NOLOCK)
											WHERE Tcd.CouponCode = Cr.CouponCode)
											)
					
					
    		END		
		/*DELETE SECTION ENDS*/	
		
		COMMIT TRANSACTION [Save_CampaignDetails]
						
		END
	
		IF (@CampaignTypeId < 1 OR @CampaignTypeId > 3)
			BEGIN
				SET @ErrorMessage = 'Unrecognised CampaignType supplied in XML '
				
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION [Save_CampaignDetails]
				END
				
				RAISERROR (
						'%s',
						16,
						1,
						@ErrorMessage
						)
			END		
					
		--Removing Temporary Table(S)
		
		DROP TABLE #TempCampaignDetails
		
		DROP TABLE #TempLinkedCouponDetails
			
		DROP TABLE #TempCampaignAttributes

		DROP TABLE #TempDiscountTypes

		DROP TABLE #TempPlanID	
		PRINT 'CAMPAIGN AND COUPON(S) EDITED IN DATABASE FOR ' + CONVERT(NVARCHAR(100),@CampaignID) + ' CampaignID'
		
	END TRY	
	
	BEGIN CATCH
			SET @ErrorMessage = @ProcSection + ERROR_MESSAGE()
	
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [Save_CampaignDetails]
			END

			IF OBJECT_ID('tempdb..#TempCampaignDetails') IS NOT NULL DROP TABLE #TempCampaignDetails
			IF OBJECT_ID('tempdb..#TempLinkedCouponDetails') IS NOT NULL DROP TABLE #TempLinkedCouponDetails
			IF OBJECT_ID('tempdb..#TempCampaignAttributes') IS NOT NULL DROP TABLE #TempCampaignAttributes
			IF OBJECT_ID('tempdb..#TempPlanID') IS NOT NULL DROP TABLE #TempPlanID
			IF OBJECT_ID('tempdb..#TempDiscountTypes') IS NOT NULL DROP TABLE #TempDiscountTypes
			RAISERROR (
					'SP - [coupon].[CampaignEdit1] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)
	END CATCH

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignEdit1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignEdit1]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit1] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CampaignEdit1] not created.',
        16,
        1
    )
END
GO







USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignStop]

		IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignStop] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignStop] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignStop]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignStop]
** DATE WRITTEN   : 27/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignStop] 
(
@CampaignID	BIGINT
)
AS

BEGIN

SET NOCOUNT ON;
DECLARE @ErrorMessage		NVARCHAR(2048)

BEGIN TRY

	BEGIN TRANSACTION [Stop_CampaignCoupon]
	
	UPDATE Coupon.Coupon
	SET	
		IsActive = 0,
		UTCUpdatedDateTime = GETUTCDATE()	
		WHERE 
			CouponID IN (SELECT CouponID 
							FROM Coupon.Coupon C
							WHERE CampaignID = @CampaignID)
	IF (@@ROWCOUNT <> 0)
	BEGIN
		UPDATE Coupon.Campaign
		SET	
			IsActive = 0,
			UTCUpdatedDateTime = GETUTCDATE()	
			WHERE 
				CampaignID = @CampaignID
	END
	ELSE
	BEGIN
		SET @ErrorMessage = 'Coupon to be stopped not found for supplied CampaignID'
		
		RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
	END
	
	COMMIT TRANSACTION 	[Stop_CampaignCoupon]
	PRINT 'CAMPAIGN AND COUPON(S) STOPPED'		
		
END TRY	
BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()

		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION [Stop_CampaignCoupon]
		END
		
		RAISERROR (
				'SP - [coupon].[CampaignStop] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
END CATCH

END
GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignStop] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignStop] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignStop] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignTypeGet]

		IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignTypeGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignTypeGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignTypeGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[CampaignTypeGet]
** DATE WRITTEN   : 06/04/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): DATA OF TABLE [Coupon].[CampaignTypeGet] WHICH IS ACTIVE
*******************************************************************************************  
*******************************************************************************************/

CREATE PROCEDURE [Coupon].[CampaignTypeGet]
AS


BEGIN

	SET NOCOUNT ON;	

	SELECT 
		CampaignTypeID as [CampaignTypeId],
		CampaignTypeName as [CampaignTypeName],
		Description
	FROM [Coupon].[CampaignTypeMaster]
	WHERE IsActive = 1 --Active Campaign
	--FOR XML PATH('SubscriptionCouponType'),TYPE,root('SubscriptionCouponTypes')

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignTypeGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignTypeGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignTypeGet] not created.',16,1)
	END
GOIF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsGet]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet] not dropped.',16,1)
			END
	END
GO





CREATE PROCEDURE [Coupon].[CouponDetailsGet]
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

	SELECT 
		CouponCode,
		DescriptionShort,
		DescriptionLong,
		Amount,
		RedeemCount,
		IsActive	
	FROM
		Coupon.Coupon c (NOLOCK)
	WHERE
		CouponCode = @CouponCode


	SELECT 
		ca.AttributeId,
		ca.AttributeValue
	FROM
		Coupon.Coupon c (NOLOCK)
	INNER JOIN 
		Coupon.CouponAttributes ca (NOLOCK)
	ON c.CouponID = ca.CouponID
	WHERE
		CouponCode = @CouponCode
	ORDER BY ca.AttributeId

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsGet1]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet1] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [Coupon].[CouponDetailsGet1]
(
	@CouponCode				NVARCHAR(25)	
)
AS


/*
	Author:		Robin
	Created:	15/Jul/2013
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN

	SET NOCOUNT ON;	

-- To get Coupon Details

SELECT 
		CC.CouponCode,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CM.Amount,
		CC.RedeemCount,
		CC.IsActive,
        CM.campaignTypeID CouponType
        FROM Coupon.Coupon CC (NOLOCK)
        INNER JOIN Coupon.Campaign CM (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        WHERE CouponCode = @CouponCode



-- To get the CustomerID for the LinkedCoupons  CASE WHEN TM.CampaignTypeID IN (1,2) THEN NULL ELSE 

    SELECT CM.CustomerID  CustomerID
    FROM [Coupon].[CouponCustomerMap] CM (NOLOCK)
    INNER JOIN [Coupon].[Coupon] CC (NOLOCK)
    ON CM.CouponID = CC.CouponID
    INNER JOIN [Coupon].[Campaign] CI (NOLOCK)
    ON CC.CampaignID = CI.CampaignID
    WHERE  CC.CouponCode = @CouponCode AND CI.CampaignTypeID=3


-- To get Coupons attributes

	SELECT 
		ca.AttributeId,
		ca.AttributeValue
	FROM
		Coupon.Coupon c (NOLOCK)
	INNER JOIN 
		Coupon.CampaignAttributes ca (NOLOCK)
	ON c.campaignid = ca.campaignid
	WHERE
		CouponCode = @CouponCode
	ORDER BY ca.AttributeId

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet1] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet1] not created.',16,1)
	END
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet2]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsGet2]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsGet2]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet2] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsGet2] not dropped.',
            16,
            1
        )
    END
END

GO


CREATE PROCEDURE [Coupon].[CouponDetailsGet2]
(
	@CouponCode				NVARCHAR(MAX)
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
BEGIN

	SET NOCOUNT ON;	

DECLARE

@Delimiter    NVARCHAR(1)

SET @Delimiter = ','

DECLARE @CouponTable TABLE  (String NVARCHAR(MAX))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))


-- To get the distinct coupon codes
SELECT 
		CC.CouponCode,
        CC.CouponID,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CM.IsActive,
        CM.campaignTypeID CouponType,
		CM.IsMutuallyExclusive
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        WHERE  CC.CouponCode  IN (SELECT String FROM @CouponTable)

-- In case of Linked Coupon

SELECT CC.CouponCode,
       CM.CustomerID
       FROM Coupon.Coupon CC  WITH (NOLOCK)
       INNER JOIN Coupon.CouponCustomerMap CM  WITH (NOLOCK)
       ON CC.CouponID = CM.CouponID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable)   

--  Get coupon Discount TypeID
 
SELECT CC.CouponCode,
       CD.DiscountTypeID,
	   CD.DiscountValue
       FROM Coupon.Coupon CC  WITH (NOLOCK)
       INNER JOIN Coupon.CampaignDiscountType CD  WITH (NOLOCK)
       ON CC.CampaignID = CD.CampaignID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable) 

--Get the coupon Attributes


SELECT CC.CouponCode,
       CA.AttributeID,
	   CA.AttributeValue
       FROM Coupon.Coupon CC  WITH (NOLOCK)
       INNER JOIN Coupon.CampaignAttributes CA  WITH (NOLOCK)
       ON CC.CampaignID = CA.CampaignID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable) 
  
--Get the Plan IDs comma seperated per coupon    
SELECT DISTINCT(C.CouponCode), 
    SUBSTRING(
        (
            SELECT ','+ CONVERT(VARCHAR,CPD1.SubscriptionPlanID) AS [text()]
            From Coupon.CampaignPlanDetails CPD1
            Where CPD1.CampaignID = CPD2.CampaignID
            ORDER BY CPD1.CampaignID
            For XML PATH ('')
        ), 2, 1000) [PlanIDs]
From Coupon.CampaignPlanDetails CPD2 WITH (NOLOCK)
INNER JOIN Coupon.Coupon C   WITH (NOLOCK)
ON CPD2.CampaignID = C.CampaignID 
INNER JOIN @CouponTable CT 
ON CT.[String] = C.CouponCode

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet2] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet2]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet2] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsGet2] not created.',
        16,
        1
    )
END
GO


USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsGet3]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet3] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsGet3] not dropped.',
            16,
            1
        )
    END
END

GO
CREATE PROCEDURE [Coupon].[CouponDetailsGet3]
(
	@CouponCode				NVARCHAR(200)
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
BEGIN

	SET NOCOUNT ON;	
DECLARE

@Delimiter    NVARCHAR(1)

SET @Delimiter = ','

DECLARE 
@CouponTable  TABLE (String NVARCHAR(44))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))

SELECT 
		CC.CouponCode,
        CC.CouponID,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CM.IsActive,
        CM.campaignTypeID CouponType,
        DM.DiscountTypeId,
        DT.Discountvalue,
        DM.DiscountName       
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        INNER JOIN Coupon.CampaignDiscountType DT WITH (NOLOCK)
        ON CM.CampaignID = DT.CampaignID
        INNER JOIN Coupon.DiscountTypeMaster DM WITH (NOLOCK) 
        ON DT.DiscountTypeID = DM.DiscountTypeID
        WHERE  CC.CouponCode  IN (SELECT String FROM @CouponTable)

-- In case of Linked Coupon

SELECT CC.CouponCode,
       CM.CustomerID
       FROM Coupon.Coupon CC WITH (NOLOCK)
       INNER JOIN Coupon.CouponCustomerMap CM WITH (NOLOCK)
       ON CC.CouponID = CM.CouponID
       Where CC.CouponCode IN (SELECT String FROM @CouponTable)     

END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet3] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet3] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsGet3] not created.',
        16,
        1
    )
END
GO



IF OBJECT_ID(N'[Coupon].[CouponDetailsGet4]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsGet4]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsGet4]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet4] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsGet4] not dropped.',
            16,
            1
        )
    END
END

GO


CREATE PROCEDURE [Coupon].[CouponDetailsGet4]
(
	@CouponCode				NVARCHAR(MAX)
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
BEGIN

	SET NOCOUNT ON;	

DECLARE

@Delimiter    NVARCHAR(1)

SET @Delimiter = ','

DECLARE @CouponTable TABLE  (String NVARCHAR(MAX))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))


-- To get the distinct coupon codes
SELECT 
		CC.CouponCode,
        CC.CouponID,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CM.IsActive,
        CM.campaignTypeID CouponType,
		CM.IsMutuallyExclusive
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        WHERE  CC.CouponCode  IN (SELECT String FROM @CouponTable)

-- In case of Linked Coupon

SELECT CC.CouponCode,
       CM.CustomerID
       FROM Coupon.Coupon CC
       INNER JOIN Coupon.CouponCustomerMap CM
       ON CC.CouponID = CM.CouponID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable)   

--  Get coupon Discount TypeID
 
SELECT CC.CouponCode,
       CD.DiscountTypeID,
	   CD.DiscountValue
       FROM Coupon.Coupon CC
       INNER JOIN Coupon.CampaignDiscountType CD
       ON CC.CampaignID = CD.CampaignID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable) 

--Get the coupon Attributes


SELECT CC.CouponCode,
       CA.AttributeID,
	   CA.AttributeValue
       FROM Coupon.Coupon CC
       INNER JOIN Coupon.CampaignAttributes CA
       ON CC.CampaignID = CA.CampaignID
       WHERE CC.CouponCode IN (SELECT String FROM @CouponTable) 

END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet4] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet4]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet4] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsGet4] not created.',
        16,
        1
    )
END
GO


IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponDetailsGetAll]
    
    IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsGetAll] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponDetailsGetAll] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponDetailsGetAll]
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Get All Coupons Details


Example:
Execute [coupon].[CouponDetailsGetAll]
--Modifications History--
Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;	
	
	SELECT c.CouponID,
	       c.CouponCode,
	       c.DescriptionShort,
	       c.DescriptionLong,
	       c.Amount,
	       c.RedeemCount,
	       c.IsActive,
	       c.UTCCreatedeDateTime,
	       (
	           SELECT ca.AttributeID,
	                  ca.AttributeValue 
	           FROM   Coupon.CouponAttributes ca	           
	           WHERE  ca.CouponID = c.CouponID
	                  FOR XML PATH('CouponAttribute'),TYPE, ROOT('CouponAttributes')
	       ) Attributes
	FROM   Coupon.Coupon c (NOLOCK)	
	ORDER BY
	       c.UTCCreatedeDateTime DESC
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponDetailsGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsGetAll] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponDetailsGetAll] not created.',
        16,
        1
    )
END
GO
IF OBJECT_ID(N'[Coupon].[CouponDetailsSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsSave]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsSave] not dropped.',16,1)
			END
	END
GO

    
CREATE PROCEDURE [Coupon].[CouponDetailsSave] 
(@CouponDetailsXML XML)
AS
	/*   
Author:  Swaraj    
Created: 04/Oct/2012    
Purpose: Save Coupons Details    

Example:    
Execute [coupon].[CouponDetailsSave] @CouponDetailsXML =     
'    
<ArrayOfCouponDetails>  
<CouponDetails CouponID="0" CouponCode="DDWDQ" DescriptionShort="Testing ADD" DescriptionLong="New" Amount="15.0000" RedeemCount="0" IsActive="false" UTCCreatedeDateTime="2012-10-10T00:00:00" UTCUpdatedDateTime="2012-10-10T00:00:00">  
<CouponAttributesList>  
<CouponAttribute>  
<AttributeID>1</AttributeID><AttributeValue>1</AttributeValue>  
</CouponAttribute>  
<CouponAttribute>  
<AttributeID>2</AttributeID><AttributeValue>2012/10/06</AttributeValue>  
</CouponAttribute>  
<CouponAttribute>  
<AttributeID>3</AttributeID><AttributeValue>2012/10/14</AttributeValue>  
</CouponAttribute>  
<CouponAttribute>  
<AttributeID>4</AttributeID><AttributeValue>500</AttributeValue>  
</CouponAttribute>  
<CouponAttribute>  
<AttributeID>5</AttributeID><AttributeValue>15</AttributeValue>  
</CouponAttribute>  
</CouponAttributesList>  
</CouponDetails>  
</ArrayOfCouponDetails>  
'    
--Modifications History--    
Changed On   Changed By  Defect  Changes  Change Description     

*/   

BEGIN
	SET NOCOUNT ON;     
	DECLARE @ErrorMessage    NVARCHAR(2048),
	        @CurrentUTCDate  SMALLDATETIME  
	
	CREATE TABLE #couponDetails
	(
		[CouponID]          [bigint] NOT NULL,
		[CouponCode]        [nvarchar](25) NOT NULL,
		[DescriptionShort]  [nvarchar](200) NULL,
		[DescriptionLong]   [nvarchar](300) NULL,
		[Amount]            [money],
		[IsActive]          [bit] NOT NULL DEFAULT((0)),
		AttributeId         SMALLINT NULL,
		AttributeValue      VARCHAR(50)
	)    
	
	SELECT @CurrentUTCDate = GETUTCDATE()
		
	INSERT INTO #couponDetails
	  (
	    CouponID,
	    CouponCode,
	    DescriptionShort,
	    DescriptionLong,
	    Amount,
	    IsActive,
	    AttributeId,
	    AttributeValue
	  )
	SELECT T.C.value('../../@CouponID[1]', 'bigint') [CouponID],
	       T.C.value('../../@CouponCode[1]', 'nvarchar(25)') [CouponCode],
	       T.C.value('../../@DescriptionShort[1]', 'NVARCHAR(200)') 
	       [DescriptionShort],
	       T.C.value('../../@DescriptionLong[1]', 'NVARCHAR(300)') 
	       [DescriptionLong],
	       T.C.value('../../@Amount[1]', 'money') Amount,
	       T.C.value('../../@IsActive[1]', 'bit') [IsActive],
	       T.C.value('AttributeID[1]', 'smallint') AttributeID,
	       T.C.value('AttributeValue[1]', 'nvarchar(50)') AttributeValue
	FROM   @CouponDetailsXML.nodes(
	           'ArrayOfCouponDetails/CouponDetails/CouponAttributesList/CouponAttribute'
	       ) T(c)    
	
	BEGIN TRY
		BEGIN TRANSACTION Save_CouponDetails 
		--Update  Coupon.Coupon
		--   
		
		UPDATE Coupon.Coupon
		SET    DescriptionShort = cd.DescriptionShort,
		       DescriptionLong = cd.DescriptionLong,
		       Amount = cd.Amount,
		       IsActive = cd.IsActive,		       
		       UTCUpdatedDateTime = @CurrentUTCDate
		FROM   #couponDetails cd
		       INNER JOIN Coupon.Coupon c
		            ON  c.CouponID = cd.CouponID 
		
		--update Coupon.CouponAttributes    
		UPDATE Coupon.CouponAttributes
		SET    AttributeValue = cd.AttributeValue,
		       UTCUpdatedDateTime = @CurrentUTCDate
		FROM   #couponDetails cd
		       INNER JOIN Coupon.CouponAttributes ca
		            ON  ca.CouponID = cd.CouponID
		            AND ca.AttributeId = cd.AttributeId 
		
		--Insert into Coupon.Coupon    
		INSERT INTO Coupon.Coupon
		  (
		    CouponCode,
		    DescriptionShort,
		    DescriptionLong,
		    Amount,
		    IsActive
		  )
		SELECT DISTINCT 
		       cd.CouponCode,
		       cd.DescriptionShort,
		       cd.DescriptionLong,
		       cd.Amount,
		       cd.IsActive
		FROM   #couponDetails cd
		       LEFT JOIN Coupon.Coupon c
		            ON  c.CouponID = cd.CouponID
		WHERE  c.CouponID IS NULL   
		
		INSERT INTO coupon.CouponAttributes
		  (
		    CouponID,
		    AttributeID,
		    AttributeValue
		  )
		SELECT C.CouponId,
		       cd.AttributeId,
		       cd.AttributeValue  
		FROM   #couponDetails CD
		       JOIN Coupon.Coupon C
		            ON  CD.CouponCode = C.CouponCode
		       LEFT JOIN Coupon.CouponAttributes ca
		            ON  ca.CouponID = C.CouponID
		            AND ca.AttributeId = CD.AttributeId
		WHERE  CA.AttributeID IS NULL 
		
		COMMIT TRANSACTION [Save_CouponDetails]
	END TRY    
	BEGIN CATCH		 
	    SET @ErrorMessage = ERROR_MESSAGE()
	     
		IF @@TRANCOUNT > 0
		BEGIN
		    ROLLBACK TRANSACTION [Save_CouponDetails]
		END 
		
		RAISERROR (
		    'SP - [coupon].[CouponDetailsSave] Error = (%s)',
		    16,
		    1,
		    @ErrorMessage
		)
	END CATCH 
	
	DROP TABLE #couponDetails
END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsSave] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CouponDetailsValidate]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsValidate]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsValidate]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsValidate] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsValidate] not dropped.',
            16,
            1
        )
    END
END

GO
CREATE PROCEDURE [Coupon].[CouponDetailsValidate]
(
	@CouponCode				NVARCHAR(25)	
)
AS


/*
	Author:		Robin
	Created:	20/Feb/2014
	Purpose:	Get coupon detils for validation based on couponCode
    Called By:  Coupon Service

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN

	SET NOCOUNT ON;	

DECLARE 
@listStr VARCHAR(200), 
@CampaignID BIGINT 

		SELECT @listStr = COALESCE(@listStr + ', ' ,'') + CONVERT(VARCHAR,PD.SubscriptionPlanID),@CampaignID= CC.CampaignID  
		FROM Coupon.CampaignPlanDetails PD WITH (NOLOCK)
		INNER JOIN Coupon.Coupon CC WITH (NOLOCK)
		ON CC.CampaignID = PD.CampaignID 
		WHERE CC.CouponCode = @CouponCode

;WITH PlanIDCTE(PlanIDs,CampaignID) AS (SELECT @listStr,@CampaignID)

-- To get Coupon Details

		SELECT 
		CC.CouponCode,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CC.IsActive,
        CM.campaignTypeID CouponType,
        PD.PlanIDs,
		CM.UsageTypeID
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        LEFT JOIN PlaniDCTE PD
        ON PD.CampaignID = CC.CampaignID
        WHERE CouponCode = @CouponCode


-- To get the CustomerID for the LinkedCoupons  CASE WHEN TM.CampaignTypeID IN (1,2) THEN NULL ELSE 

		SELECT 
		CM.CustomerID AS CustomerID
		FROM [Coupon].[CouponCustomerMap] CM WITH (NOLOCK)
		INNER JOIN [Coupon].[Coupon] CC WITH (NOLOCK)
		ON CM.CouponID = CC.CouponID
		INNER JOIN [Coupon].[Campaign] CI WITH (NOLOCK)
		ON CC.CampaignID = CI.CampaignID
		WHERE  CC.CouponCode = @CouponCode AND CI.CampaignTypeID=3


-- To get Coupons attributes

		SELECT 
		ca.AttributeId,
		ca.AttributeValue
		FROM Coupon.Coupon CC WITH (NOLOCK)
		INNER JOIN Coupon.CampaignAttributes CA WITH (NOLOCK)
		ON CC.campaignid = CA.campaignid
        WHERE CC.CouponCode = @CouponCode
		AND CA.AttributeId <>1
		ORDER BY CA.AttributeId

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsValidate] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsValidate]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsValidate] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsValidate] not created.',
        16,
        1
    )
END
GO

IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponDetailsXMLGet]
    
    IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsXMLGet] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponDetailsXMLGet] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponDetailsXMLGet]
(
	@couponId BIGINT
)
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Get Coupons Details of Single Coupon


Example:
Execute [coupon].[CouponDetailsXMLGet] 70
--Modifications History--
Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;	
	
	SELECT c.CouponID,
	       c.CouponCode,
	       c.DescriptionShort,
	       c.DescriptionLong,
	       c.Amount,
	       c.RedeemCount,
	       c.IsActive,
	       c.UTCCreatedeDateTime,
	       (
	           SELECT ca.AttributeID,
	                  ca.AttributeValue
	           FROM   Coupon.CouponAttributes ca
	           WHERE  ca.CouponID = c.CouponID
	                  FOR XML PATH('CouponAttribute'),TYPE, ROOT('CouponAttributes')
	       ) Attributes
	FROM   Coupon.Coupon c 
	WHERE c.CouponId = @couponId
	ORDER BY
	       c.UTCCreatedeDateTime DESC
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponDetailsXMLGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsXMLGet] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponDetailsXMLGet] not created.',
        16,
        1
    )
END
GO
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
IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponRedemptionSave]

		IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponRedemptionSave] not dropped.',16,1)
			END
	END
GO





CREATE PROCEDURE [Coupon].[CouponRedemptionSave]
(
	@CouponCode NVARCHAR(25)
	,@CustomerID BIGINT	
)
AS

/*
	Author:		Manjunathan
	Created:	18/Sep/2012
	Purpose:	Create Coupon Redemption

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

	*/

BEGIN
	SET NOCOUNT ON;	

	DECLARE	 @errorDescription	NVARCHAR(2048)
		,@error				INT
		,@errorProcedure	SYSNAME
		,@errorLine			INT
	  
	BEGIN TRY
 
	BEGIN TRANSACTION
		
	INSERT INTO [TescoSubscription].[Coupon].[CouponRedemption]
           ([CouponCode]
           ,[CustomerID]           )
     VALUES
           (@CouponCode
			,@CustomerID)
			
	UPDATE Coupon.Coupon
	SET RedeemCount = RedeemCount + 1
		,UTCUpdatedDateTime = GETUTCDATE()
	WHERE 
		CouponCode = @CouponCode
		
	COMMIT TRANSACTION 
	
	END TRY
	BEGIN CATCH

	  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
				  , @error                = ERROR_NUMBER()
				  , @errorDescription     = ERROR_MESSAGE()
				  , @errorLine            = ERROR_LINE()
	  FROM  INFORMATION_SCHEMA.ROUTINES
	  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

	 ROLLBACK TRANSACTION 
	 
	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
 
	END CATCH


END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponRedemptionSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponRedemptionSave] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponRedemptionSave3]
    
    IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave3] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponRedemptionSave3] not dropped.',
            16,
            1
        )
    END
END

GO

CREATE PROCEDURE [Coupon].[CouponRedemptionSave3]
(
	@CouponCode NVARCHAR(MAX)
   ,@CustomerID BIGINT	
)
AS
/*
	Author:		Robin
	Created:	21 Jan 2014 
	Purpose:	To increase the coupon redemption count and map customerid to couponid

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;	


	SET NOCOUNT ON;	

DECLARE
 @errorDescription	NVARCHAR(2048)
,@error				INT
,@errorProcedure	SYSNAME
,@errorLine			INT
,@Delimiter    NVARCHAR(1)
,@String       NVARCHAR(25)
 
SET @Delimiter = ','

DECLARE @CouponTable  TABLE (String NVARCHAR(44))
 

INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))

--    END

	  
    BEGIN TRY
 
		BEGIN TRANSACTION
	--SELECT 1/0
		INSERT INTO [Coupon].[CouponRedemption]
			 ([CouponCode]
			 ,[CustomerID])
				(SELECT UPPER(String),@CustomerID FROM @CouponTable)

	     
				
		UPDATE [Coupon].[Coupon]
		SET RedeemCount = RedeemCount + 1
			,UTCUpdatedDateTime = GETUTCDATE()
		WHERE 
			CouponCode IN (SELECT String FROM @CouponTable)

		 
			
		COMMIT TRANSACTION 
		
	END TRY
	BEGIN CATCH

		 SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
					  , @error                = ERROR_NUMBER()
					  , @errorDescription     = ERROR_MESSAGE()
					  , @errorLine            = ERROR_LINE()
		 FROM  INFORMATION_SCHEMA.ROUTINES
		 WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		 ROLLBACK TRANSACTION 
		 
		 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 
	END CATCH


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponRedemptionSave3] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave3] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponRedemptionSave3] not created.',
        16,
        1
    )
END
GO

IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponStop]
    
    IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponStop] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponStop] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponStop]
(
    @CouponId Bigint
)
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Stop a Coupons

execute coupon.couponstop 1
--Modifications History--
Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;
	
	UPDATE Coupon.Coupon
		SET	
			IsActive = 0,
			UTCUpdatedDateTime = GETUTCDATE()	
		WHERE 
			CouponID = @CouponId
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponStop] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponStop] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponStop] not created.',
        16,
        1
    )
END
GO
USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CouponUnredemptionSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponUnredemptionSave]

		IF OBJECT_ID(N'[Coupon].[CouponUnredemptionSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponUnredemptionSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponUnredemptionSave] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CouponUnredemptionSave]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CouponUnredemptionSave]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	15 Jul 2013		Navdeep_Singh					RedemptionFix of value 1
	23 Jul 2013		Navdeep_Singh					Incorporating Manju's logic fro redemption

*/

CREATE PROCEDURE [Coupon].[CouponUnredemptionSave]
(
	@CouponCode NVARCHAR(25)
	,@CustomerID BIGINT	
)
AS

BEGIN
	SET NOCOUNT ON;	

	DECLARE	 @errorDescription	NVARCHAR(2048)
		,@error				INT
		,@errorProcedure	SYSNAME
		,@errorLine			INT
	  
	BEGIN TRY
 
	BEGIN TRANSACTION 
		
	;WITH DelCoup AS
	( SELECT TOP 1 CouponCode FROM [TescoSubscription].[Coupon].[CouponRedemption]
      WHERE CustomerID = @CustomerID AND CouponCode=@CouponCode
      ORDER BY UTCCreatedDateTime DESC 
	)

	DELETE FROM DelCoup
      
	
	IF @@ROWCOUNT = 1 
	BEGIN		
		UPDATE Coupon.Coupon
		SET RedeemCount = RedeemCount - 1
			,UTCUpdatedDateTime = GETUTCDATE()
		WHERE 
			CouponCode = @CouponCode
		
	COMMIT TRANSACTION 	

	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION 
		
		RAISERROR (
				'SP - [coupon].[CouponUnRedemptionSave] Error = (%s)',
				16,
				1,
				'No record'
				)
	END	
	
	

	END TRY
	BEGIN CATCH

	IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION 
			END

	  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
				  , @error                = ERROR_NUMBER()
				  , @errorDescription     = ERROR_MESSAGE()
				  , @errorLine            = ERROR_LINE()
	  FROM  INFORMATION_SCHEMA.ROUTINES
	  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
 
	END CATCH


END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponUnredemptionSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponUnredemptionSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponUnredemptionSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponUnredemptionSave] not created.',16,1)
	END
GO

USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupon]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[SearchCoupon]

		IF OBJECT_ID(N'[Coupon].[SearchCoupon]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupon] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[SearchCoupon] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[SearchCoupon]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[SearchCoupon]
** DATE WRITTEN   : 11th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	23 July 2013	Navdeep_Singh					Incorporated Review Comments from Manju

*/

CREATE PROCEDURE Coupon.SearchCoupon
(
@CouponCode		NVARCHAR(25)	= NULL,
@CustomerID		BIGINT			= NULL
)
AS

BEGIN

SET NOCOUNT ON

DECLARE @ErrorMessage    NVARCHAR(2048)

IF (@CouponCode IS NULL AND @CustomerID IS NULL)
	BEGIN 
		SET @ErrorMessage = 'Either, CustomerID or CouponCode should be supplied'
			
		RAISERROR (
		'SP - [Coupon].[SearchCoupon] Error = %s',
		16,
		1,
		@ErrorMessage
		)
	END


IF (@CouponCode IS NOT NULL)
	BEGIN
	
	;WITH CampAttrUn
	AS
	(SELECT PVT.CampaignId
			,PVT.[1] SubscriptionPlanId
			,CAST(SUBSTRING(PVT.[2],6,2)+'/'+SUBSTRING(PVT.[2],9,2)+'/'+SUBSTRING(PVT.[2],1,4) AS VARCHAR(10)) EffectiveStartDateTime
			,CAST(SUBSTRING(PVT.[3],6,2)+'/'+SUBSTRING(PVT.[3],9,2)+'/'+SUBSTRING(PVT.[3],1,4) AS VARCHAR(10)) EffectiveEndDateTime
			,PVT.[4] MaxRedemption
			,PVT.[5] LapsePeriod
			,PVT.[6] CouponsGeneratedCount 
			,CouponID
		FROM
			(
			SELECT C.CampaignId,
					AttributeValue,
					AttributeID	
					,CouponID		
			FROM Coupon.Coupon CP (NOLOCK)
			JOIN Coupon.Campaign C  (NOLOCK)
			ON CouponCode=@CouponCode AND C.CampaignID=CP.CampaignID 	
			JOIN Coupon.CampaignAttributes CA  (NOLOCK)
				ON CA.CampaignID = C.CampaignID	
			) TempA
			PIVOT (
				 MIN(Attributevalue)
				 FOR AttributeID in ([1],[2],[3],[4],[5],[6])
			) PVT
		)			
		SELECT	C.CouponID													
				,C.CouponCode
				,Cmp.CampaignID
				,Cmp.CampaignCode
				,CONVERT(VARCHAR(10),CampAttrUn.EffectiveStartDateTime,101)		AS ValidFrom
				,CONVERT(VARCHAR(10),CampAttrUn.EffectiveEndDateTime,101)		AS ValidTo					
				,Cmp.Amount														AS AmountOff
				,CASE WHEN C.RedeemCount <> 0 
					THEN 'Yes' 
					ELSE 'No' 
				END																AS IsRedeemed
				,Ccm.CustomerID													AS CustomerIDIsLinked
				,Cr.CustomerID													AS CustomerIDRedeemed		
				,CONVERT(VARCHAR(10),Cr.UTCCreatedDateTime,101)					AS RedemptionDate					
				,CampAttrUn.SubscriptionPlanID		
				,Cmp.CampaignTypeID
				,CampAttrUn.LapsePeriod
				,Cmp.DescriptionShort											AS InternalDescription
				,Cmp.DescriptionLong											AS ExternalDescription
				,CampAttrUn.MaxRedemption
				,C.RedeemCount													AS CouponRedeemedHowManyTimes
			FROM  CampAttrUn WITH (NOLOCK)
				INNER JOIN Coupon.Coupon C (NOLOCK)
					ON CampAttrUn.CouponID = C.CouponID
				INNER JOIN Coupon.Campaign Cmp (NOLOCK)
					ON Cmp.CampaignID = CampAttrUn.CampaignID
				LEFT OUTER JOIN Coupon.CouponCustomerMap Ccm (NOLOCK)
					ON Ccm.CouponID = C.CouponID
				LEFT OUTER JOIN Coupon.CouponRedemption Cr (NOLOCK)
					ON Cr.CouponCode = C.CouponCode
			ORDER BY RedemptionDate DESC
			
	END
ELSE -- Search to go ahead with CustomerID
	BEGIN
	
	;With CRTemp
	AS
	(SELECT CampaignID,C.CouponCode,CustomerID,UTCCreatedDateTime FROM Coupon.CouponRedemption CR (NOLOCK)
		JOIN Coupon.Coupon C (NOLOCK)
		ON C.CouponCode=CR.CouponCode 
		AND CustomerID=@CustomerID
	 )
	 , CMTemp
	 AS
	 (
	 SELECT CampaignID,CM.CouponID,CustomerID FROM Coupon.CouponCustomerMap CM (NOLOCK)
		JOIN Coupon.Coupon C (NOLOCK)
		ON C.CouponID=CM.CouponID 
		WHERE CustomerID=@CustomerID
	)
	, CampAttr
		AS
		(SELECT PVT.CampaignId
				,PVT.[1] SubscriptionPlanId
				,CAST(SUBSTRING(PVT.[2],6,2)+'/'+SUBSTRING(PVT.[2],9,2)+'/'+SUBSTRING(PVT.[2],1,4) AS VARCHAR(10)) EffectiveStartDateTime
				,CAST(SUBSTRING(PVT.[3],6,2)+'/'+SUBSTRING(PVT.[3],9,2)+'/'+SUBSTRING(PVT.[3],1,4) AS VARCHAR(10)) EffectiveEndDateTime
				,PVT.[4] MaxRedemption
				,PVT.[5] LapsePeriod
				,PVT.[6] CouponsGeneratedCount
			FROM
				(
				SELECT C.CampaignId,
						AttributeValue,
						AttributeID			
				FROM  (SELECT CampaignID FROM CRTemp WITH (NOLOCK)
						UNION
						SELECT CampaignID FROM CMTemp WITH (NOLOCK)) CT
				JOIN Coupon.Campaign C (NOLOCK)
					ON C.CampaignID=CT.CampaignID	
			   JOIN Coupon.CampaignAttributes CA (NOLOCK)
					ON CA.CampaignID = C.CampaignID
				) TempA
				PIVOT (
					 MIN(Attributevalue)
					 FOR AttributeID in ([1],[2],[3],[4],[5],[6])
				) PVT
		)
		SELECT	C.CouponID													
				,C.CouponCode
				,Cmp.CampaignID
				,Cmp.CampaignCode
				,CONVERT(VARCHAR(10),CampAttr.EffectiveStartDateTime,101)		AS ValidFrom
				,CONVERT(VARCHAR(10),CampAttr.EffectiveEndDateTime,101)			AS ValidTo					
				,Cmp.Amount														AS AmountOff
				,CASE WHEN C.RedeemCount <> 0 
					THEN 'Yes' 
					ELSE 'No' 
				END																AS IsRedeemed
				,Ccm.CustomerID													AS CustomerIDIsLinked
				,Cr.CustomerID													AS CustomerIDRedeemed		
				,CONVERT(VARCHAR(10),Cr.UTCCreatedDateTime,101)					AS RedemptionDate					
				,CampAttr.SubscriptionPlanID		
				,Cmp.CampaignTypeID
				,CampAttr.LapsePeriod
				,Cmp.DescriptionShort											AS InternalDescription
				,Cmp.DescriptionLong											AS ExternalDescription
				,CampAttr.MaxRedemption
				,C.RedeemCount													AS CouponRedeemedHowManyTimes
				FROM  CampAttr  WITH (NOLOCK)
				INNER JOIN Coupon.Campaign Cmp (NOLOCK)
					ON Cmp.CampaignID = CampAttr.CampaignID
				INNER JOIN Coupon.Coupon C (NOLOCK)
					ON Cmp.CampaignID = C.CampaignID
				LEFT OUTER JOIN CMTemp Ccm (NOLOCK)
					ON Ccm.CouponID = C.CouponID
				LEFT OUTER JOIN CRTemp Cr (NOLOCK)
					ON Cr.CouponCode = C.CouponCode
		WHERE ( Ccm.CustomerID = @CustomerID OR  Cr.CustomerID = @CustomerID )
		ORDER BY RedemptionDate DESC	
	END
END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[SearchCoupon] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupon]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupon] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[SearchCoupon] not created.',16,1)
	END
GOUSE [TescoSubscription]
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[SearchCoupons]

		IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupons] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[SearchCoupons] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [Coupon].[SearchCoupons] 
(
@CampaignID BIGINT = NULL
,@PageCount INT
,@PageSize INT
)
AS
/*  
    Author:			Robin
	Date created:	25 Apr 2014
	Purpose:		To get Campaign Details Based on CampaignID
	Behaviour:		
	Usage:			Often/Hourly
	Called by:		Juvo
	WarmUP Script:	Execute [Coupon].[SearchCoupons]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/
 

BEGIN
DECLARE
       @Size      INT

IF @PageSize = -1 

BEGIN
     SET @Size = (Select Count(1) From Coupon.Coupon) 
	 SET @PageCount=1 
END
			
ELSE 
     SET @Size = @PageSize 



	 SELECT TOP (@Size) *  FROM(			
			SELECT ROW_NUMBER() OVER (ORDER BY TempT.[CouponID] DESC
											)
							AS RowNumber
			, TempT.*
	   FROM(SELECT CC.CouponID,
	 CC.CouponCode,
	 CA.DescriptionLong,
	 CCM.CustomerID
	 From Coupon.Coupon CC WITH (NOLOCK) INNER JOIN Coupon.Campaign CA WITH (NOLOCK)
	 ON CC.CampaignID=CA.CampaignID
	 LEFT OUTER JOIN Coupon.CouponCustomerMap CCM
	 ON CC.CouponID=CCM.CouponID
	 where CC.CampaignID=@CampaignID	
	)TempT	
	)Temp	
	WHERE   RowNumber > (@PageCount - 1)*@Size
			ORDER BY RowNumber


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[SearchCoupons] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupons] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[SearchCoupons] not created.',16,1)
	END
GO

USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[UnredeemedCouponGet]

		IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[UnredeemedCouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[UnredeemedCouponGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[UnredeemedCouponGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[UnredeemedCouponGet]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : Coupon(s) which aren't redeemed
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[UnredeemedCouponGet] 
(
@CampaignID				BIGINT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @CampaignTypeID			INT
	
BEGIN TRY

	SELECT @CampaignTypeID = C.CampaignTypeID 
	FROM
		Coupon.Campaign C
	WHERE C.CampaignID = @CampaignID 
	
	IF (@@ROWCOUNT  = 0)
		BEGIN
			SET @ErrorMessage = 'Unable to Determine CampaignTypeID for the supplied CampaignID'
					
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
	ELSE
		BEGIN		
			SELECT 
				C.CouponCode, 
				CCM.CustomerID 
			FROM Coupon.Coupon C (NOLOCK)  
				INNER JOIN Coupon.CouponCustomerMap CCM (NOLOCK)
				ON C.CouponID = CCM.CouponID
			WHERE C.CampaignID = @CampaignID 
			AND NOT EXISTS (SELECT 1 FROM Coupon.CouponRedemption Cr (NOLOCK)
							WHERE C.CouponCode = Cr.CouponCode) 								
	END
	
	END TRY
	BEGIN CATCH
	SET @ErrorMessage = ERROR_MESSAGE()
	
	IF OBJECT_ID('tempdb..#CustomerLinkedCoupons') IS NOT NULL DROP TABLE #CustomerLinkedCoupons									
		
			RAISERROR (
					'SP - [coupon].[UnredeemedCouponGet] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)			
	END CATCH
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[UnredeemedCouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[UnredeemedCouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[UnredeemedCouponGet] not created.',16,1)
	END
GO
	

CREATE PROCEDURE [dbo].[pxshGASHistoryDeliverySaver]      
(      
@branchlist  varchar(2000)= null      
)      
      
AS      
    
SELECT  CASE   
  WHEN SubscriptionPlanID = 1 THEN '3 Month Plan'    
  WHEN SubscriptionPlanID = 2 THEN '6 Month Plan'   
  WHEN SubscriptionPlanID = 5 THEN '3 Month Midweek Plan'   
  WHEN SubscriptionPlanID = 6 THEN '6 Month Midweek Plan'   
  END as software,    
    convert(char(11),CustomerPlanStartDate, 112) as orderdate,    
      datepart(hh, CustomerPlanStartDate) as orderhour,count(*) as orders    
 FROM [tescosubscription].[CustomerSubscription] (nolock)    
Where [SubscriptionStatus] = 8    
and CustomerPlanStartDate between dateadd(dd, -15, getdate()) and getdate()    
and SwitchCustomerSubscriptionID IS NULL
group by    
  SubscriptionPlanID, convert(char(11),CustomerPlanStartDate, 112) ,datepart(hh, CustomerPlanStartDate)
  order by software DESC, orderdate, orderhour      
        
        
GO
IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE [dbo].[pxshGASHistoryDeliverySaver2]

		IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [dbo].[pxshGASHistoryDeliverySaver2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [dbo].[pxshGASHistoryDeliverySaver2] not dropped.',16,1)
			END
	END
GO

/*
Author:  Peter, Hall    
Created: 2012/11    
Purpose: Get Delivery Saver subscription sign up history information for GAS  

--Modifications History--    
Changed On   Changed By  	Defect  Changes  Change Description     
19/07/2013   Deepmala, Trivedi	N/A     Extened to include 4 new additional plans
					3 Month Anytime Plan - Pay Monthly, 6 Month Anytime Plan - Pay Monthly,   
					3 Month Midweek Plan - Pay Monthly & 6 Month Midweek Plan - Pay Monthly
*/   

CREATE PROCEDURE [dbo].[pxshGASHistoryDeliverySaver2]      
(      
@branchlist  varchar(2000)= null      
)           
AS      
    
SELECT  CASE   
  WHEN SubscriptionPlanID = 1 THEN '3 Month Anytime Plan - Pay Upfront'    
  WHEN SubscriptionPlanID = 2 THEN '6 Month Anytime Plan - Pay Upfront'   
  WHEN SubscriptionPlanID = 5 THEN '3 Month Midweek Plan - Pay Upfront'   
  WHEN SubscriptionPlanID = 6 THEN '6 Month Midweek Plan - Pay Upfront' 
  WHEN SubscriptionPlanID = 7 THEN '3 Month Anytime Plan - Pay Monthly'
  WHEN SubscriptionPlanID = 8 THEN '6 Month Anytime Plan - Pay Monthly'   
  WHEN SubscriptionPlanID = 9 THEN '3 Month Midweek Plan - Pay Monthly'
  WHEN SubscriptionPlanID = 10 THEN '6 Month Midweek Plan - Pay Monthly'
  END as software,    
    convert(char(11),CustomerPlanStartDate, 112) as orderdate,    
      datepart(hh, CustomerPlanStartDate) as orderhour,count(*) as orders    
 FROM [tescosubscription].[CustomerSubscription] (nolock)    
Where [SubscriptionStatus] = 8    
and CustomerPlanStartDate between dateadd(dd, -15, getdate()) and getdate()    
and SwitchCustomerSubscriptionID IS NULL
group by    
  SubscriptionPlanID, convert(char(11),CustomerPlanStartDate, 112) ,datepart(hh, CustomerPlanStartDate)
  order by software DESC, orderdate, orderhour      
        
        
GO

GRANT EXECUTE ON [dbo].[pxshGASHistoryDeliverySaver2] TO [hs_central_supp]

IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [dbo].[pxshGASHistoryDeliverySaver2] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [dbo].[pxshGASHistoryDeliverySaver2] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDEIF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CountryCurrencyGet]

		IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CountryCurrencyGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CountryCurrencyGet] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[CountryCurrencyGet] 
AS

/*

	Author:			Praneeth Raj
	Date created:	26 July 2011
	Purpose:		To get all the Country Currencies
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [BOASubscription].[CountryCurrencyGet] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	26-July-2011	Sheshgiri Balgi		<TFS no.>	Changed	Return Type to xml
    06-12-2012      Robin               Added country currency   
*/

BEGIN

	   SET NOCOUNT ON		
	
	   SELECT [CountryCurrencyID]  'CountryCurrencyID',
              [CountryCode]        'CountryCode' ,
			  [CountryCurrency]	   'CountryCurrency'    
	   FROM   [tescosubscription].[CountryCurrencyMap] (NOLOCK)
	   FOR XML PATH('CountryCodeDetail'),TYPE,root('CountryCodeDetails')
END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CountryCurrencyGet] TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CountryCurrencyGet]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CountryCurrencyGet] not created.',16,1)
		
	END
GO


IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CountryCurrencyGet1] 

		IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CountryCurrencyGet1] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CountryCurrencyGet1] not dropped.',16,1)
				
			END
	END
GO
CREATE PROCEDURE [tescosubscription].[CountryCurrencyGet1] 
AS

/*

	Author:			Robin John
	Date created:	05 Dec 2012
	Purpose:		To get all the Country Currencies
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [BOASubscription].[CountryCurrencyGet] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	12/06/2012		Robin							Correction ** CREATE PROCEDURE
	12/12/2012		Robin							Added WITH (NOLOCK)   
*/

BEGIN

	   SET NOCOUNT ON		
	
	   SELECT [CountryCurrencyID]  'CountryCurrencyID',
              [CountryCode]        'CountryCode',
              [CountryCurrency]    'CountryCurrency'        
	   FROM   [tescosubscription].[CountryCurrencyMap]	WITH (NOLOCK)      
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CountryCurrencyGet1]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CountryCurrencyGet1] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CountryCurrencyGet1] not created.',16,1)
		
	END
GO



USE [TescoSubscription]
GO
IF OBJECT_ID(N'[tescosubscription].[CouponPaymentRemove]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [tescosubscription].[CouponPaymentRemove]
    
    IF OBJECT_ID(N'[tescosubscription].[CouponPaymentRemove]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [tescosubscription].[CouponPaymentRemove] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [tescosubscription].[CouponPaymentRemove] not dropped.',
            16,
            1
        )
    END
END

GO

CREATE PROCEDURE [tescosubscription].[CouponPaymentRemove]
(
@CustomerId BIGINT,
@Token  NVARCHAR(200)
)AS

/*
	Author:			Robin
	Date created:	20/03/2014
	Purpose:		Applies Coupon Details in Payment Table	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<DeliverySaver Website>	

    --Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
BEGIN
DECLARE
	
	 @errorDescription	NVARCHAR(2048)
	,@error				INT
	,@errorProcedure    SYSNAME
	,@errorLine	        INT
	,@Delimiter       NVARCHAR(1)
	,@String          NVARCHAR(44)

SET  @Delimiter = ','

BEGIN TRY
BEGIN TRANSACTION  

		;WITH CouponRemove AS
			  (SELECT CustomerPaymentID,Customerid,PaymentModeID
			   FROM  [Tescosubscription].[CustomerPayment] WITH (NOLOCK)
			   WHERE CustomerID = @CustomerID 
			   AND CAST(PaymentToken AS VARBINARY(90)) IN (SELECT CAST([Item] AS VARBINARY(90)) FROM [dbo].[ConvertListToTable] (@Token,@Delimiter))
     		   AND Isactive = 1 and IsFirstPaymentdue=1)
  
		DELETE CouponRemove    

COMMIT TRANSACTION  
END TRY

BEGIN CATCH

         SELECT @errorProcedure       = Routine_Schema  + '.' + Routine_Name
              , @error                = ERROR_NUMBER()
              , @errorDescription     = ERROR_MESSAGE()
              , @errorLine            = ERROR_LINE()
         FROM  INFORMATION_SCHEMA.ROUTINES
         WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

         ROLLBACK TRANSACTION  

         RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
END CATCH

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CouponPaymentRemove] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CouponPaymentRemove]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [tescosubscription].[CouponPaymentRemove] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [tescosubscription].[CouponPaymentRemove] not created.',
        16,
        1
    )
END
GO

USE [TescoSubscription]
GO
IF OBJECT_ID(N'[tescosubscription].[CouponPaymentSave]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [tescosubscription].[CouponPaymentSave]
    
    IF OBJECT_ID(N'[tescosubscription].[CouponPaymentSave]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [tescosubscription].[CouponPaymentSave] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [tescosubscription].[CouponPaymentSave] not dropped.',
            16,
            1
        )
    END
END

GO


CREATE PROCEDURE [tescosubscription].[CouponPaymentSave]
(
@CustomerId BIGINT,
@CustomerSubscriptionID BIGINT,
@IsActive	BIT,
@Token  NVARCHAR(44), 
@Remarks    VARCHAR(100),
@PaymentMode        TINYINT,
@PaymentStatus   TINYINT,
@IsFirstPaymentDue     BIT,
@PackExeHistId BIGINT,
@Channel INT,
--@CouponAppliedTyp   TINYINT,
@Amount                MONEY
)
AS

/*

	Author:			HarshaByloor
	Date created:	20/03/2014
	Purpose:		Applies Coupon Details in Payment Table	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<DeliverySaver Website>

    --Modifications History--
 	Changed On    Changed By   Defect   Changes   Change  Description 

	
*/
BEGIN

     DECLARE 
			 @errorDescription	NVARCHAR(2048)
			,@error				INT
			,@errorProcedure    SYSNAME
			,@errorLine	        INT
            ,@RowCount          INT
            ,@CustomerPaymentID BIGINT
 			
	If @PaymentMode = 2
			BEGIN	
				set @Token = upper(@Token)
			END

      SELECT @CustomerPaymentID = CustomerPaymentID FROM [tescosubscription].[CustomerPayment]
             WHERE CustomerID		=	@CustomerID
			 AND		CAST(PaymentToken AS VARBINARY(90))	=	CAST(@Token AS VARBINARY(90))
			 AND		PaymentModeID	=	@PaymentMode
             AND     IsActive = 1
        SELECT @RowCount = @@RowCount
	   
	
BEGIN TRY
		DECLARE 
              @CustomerPayment TABLE (CustomerPaymentID BIGINT)

        BEGIN TRANSACTION CouponPaymentSave
		
    
	    IF @CustomerID IS NOT NULL AND @RowCount = 0           
        BEGIN 
		
			INSERT INTO tescosubscription.Customerpayment
						   (CustomerID,
							PaymentModeId,
							PaymentToken,
							IsActive,
							IsFirstPaymentDue)					
			OUTPUT inserted.CustomerPaymentID INTO @CustomerPayment
				VALUES
						   (@CustomerId,
							@PaymentMode,
							@Token,
							@IsActive,
							@IsFirstPaymentDue)

			SELECT CustomerPaymentID FROM @CustomerPayment
         
	    END

        ELSE if @customersubscriptionid IS NULL

        PRINT 'The Provided Token ' + @Token + ' Already Exists'

		ELSE
		INSERT INTO @CustomerPayment VALUES (@CustomerPaymentID)
      
		IF @CustomerSubscriptionID IS NOT NULL

		BEGIN
			DECLARE
			@PaymentHistory  TABLE (CustomerPaymentHistoryID  BIGINT)

			INSERT INTO [tescosubscription].[CustomerPaymentHistory]
						   ([CustomerPaymentID]
						   ,[CustomerSubscriptionID]
						   ,[PaymentDate]
						   ,[PaymentAmount]
						   ,[ChannelID]
						   ,[IsEmailSent]
						   ,[PackageExecutionHistoryID])
			OUTPUT inserted.CustomerPaymentHistoryID  INTO @PaymentHistory
				SELECT  CustomerPaymentID,
						@CustomerSubscriptionID,
						GETDATE(),
						@Amount,
						@Channel,
						0,
						@PackExeHistId FROM @CustomerPayment

			 SELECT CustomerPaymentHistoryID FROM @PaymentHistory
		     
			INSERT INTO [Tescosubscription].[CustomerPaymentHistoryResponse]
					   (CustomerPaymentHistoryID
						,PaymentStatusID
						,Remarks
						)
			  OUTPUT INSERTED.CustomerPaymentHistoryResponseID
       			  SELECT CustomerPaymentHistoryID,
						 @PaymentStatus,
						 @Remarks
						 FROM @PaymentHistory

    END

COMMIT TRANSACTION CouponPaymentSave
	
END TRY
	BEGIN CATCH

      SELECT   @errorProcedure       = Routine_Schema  + '.' + Routine_Name
             , @error                = ERROR_NUMBER()
             , @errorDescription     = ERROR_MESSAGE()
             , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

    ROLLBACK TRANSACTION CouponPaymentSave

      RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	END CATCH
END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CouponPaymentSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CouponPaymentSave]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [tescosubscription].[CouponPaymentSave] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [tescosubscription].[CouponPaymentSave] not created.',
        16,
        1
    )
END
GO
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
    
USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerActiveCouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerActiveCouponGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerActiveCouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerActiveCouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerActiveCouponGet] not dropped.',16,1)
			END
	END
GO  
  
CREATE PROCEDURE [tescosubscription].[CustomerActiveCouponGet]  
(  
 @CustomerID BIGINT  
)  
AS
/*
	Author:		Robin
	Created:	17/April/2014
	Purpose:	Get PaymentToken(coupon) and Plan Amount Based on CustomerID 

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/ 
BEGIN  
DECLARE @Active TINYINT
, @Suspended TINYINT

SET  @Active = 8
SET  @Suspended = 7

	 SET NOCOUNT ON  
	  
	 SELECT PaymentToken  
	 FROM TescoSubscription.CustomerPayment WITH (NOLOCK)  
	 WHERE CustomerID = @CustomerID AND IsActive = 1 AND IsFirstPaymentdue=1 AND PaymentModeID=2  
	   
	 SELECT PlanAmount FROM Tescosubscription.SubscriptionPlan SP WITH (NOLOCK)   
	 WHERE SP.SubscriptionPlanID IN (SELECT COALESCE(SwitchTo,SubscriptionPlanID) 
	 FROM TescoSubscription.CustomerSubscription   
	 WHERE CustomerId = @CustomerID AND SubscriptionStatus in (@Active,@Suspended) 
	 )  
  
END  




GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerActiveCouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerActiveCouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerActiveCouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerActiveCouponGet] not created.',16,1)
	END
GOUSE TESCOSUBSCRIPTION
GO
	
IF OBJECT_ID(N'[tescosubscription].[CustomerActiveSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerActiveSubscriptionsGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerActiveSubscriptionsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] not dropped.',16,1)
			END
	END
GO
	
CREATE PROCEDURE [tescosubscription].[CustomerActiveSubscriptionsGet]
	@CustomerDateXML XML
AS
/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [tescosubscription].[CustomerActiveSubscriptionsGet]  
** AUTHOR         : Navdeep B. Singh 
** DESCRIPTION    : Brings Active subscriptions for Customer(s) in CSV format.
** DATE WRITTEN   : 12th May 2014                  
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
** USAGE		  :	OFTEN
** CALLED BY	  :	JUVO
*******************************************************************************************  
*******************************************************************************************/
/*SAMPLE INPUT XML:-	
	
	<CustomerDateCollection>
	  <CustomerDateRecord>
		<CustomerID>3188294</CustomerID>
		<UpdateDate>2014-02-22 09:40:50.590</UpdateDate>
	  </CustomerDateRecord>
	  <CustomerDateRecord>
		<CustomerID>2300273634</CustomerID>
		<UpdateDate>2014-05-03 23:30:08.422</UpdateDate>
	  </CustomerDateRecord>
	  <CustomerDateRecord>
		<CustomerID>16250916</CustomerID>
		<UpdateDate>2014-02-22 09:40:50.581</UpdateDate>
	  </CustomerDateRecord>
	  <CustomerDateRecord>
		<CustomerID>2300273631</CustomerID>
		<UpdateDate>2014-05-18 23:30:25.210</UpdateDate>
	  </CustomerDateRecord>
	</CustomerDateCollection>
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description	
	22 June 14		Parshant Garg					1. Added UpdateDate to the output			
													2. Allowed all the input values to be returned even if customer subscription not found 
*/

BEGIN	
	SET NOCOUNT ON;
	
	DECLARE @XmlDocumentHandle		INT
	
	-- CREATE AN INTERNAL REPRESENTATION OF THE XML DOCUMENT.	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @CustomerDateXML
	
	--INSERT INTO #TempXMLData
	SELECT TempCustDateData.*						
	INTO #TempXMLData
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'CustomerDateCollection/CustomerDateRecord',2)
		WITH (CustomerID	BIGINT,
			  UpdateDate	DATETIME
			  )
		)TempCustDateData
	
	EXEC sp_xml_removedocument @XmlDocumentHandle	
	
	;WITH CTE
	AS
	(
	SELECT  ROW_NUMBER() OVER (PARTITION BY CS.CustomerID ORDER BY CS.UTCUpdatedDateTime DESC ) AS RowNum 
			,TmpAlias.CustomerID
			,SP.PlanName AS CSVActivePlans
			,CS.UTCUpdatedDateTime
			,TmpAlias.UpdateDate,CS.Customerplanstartdate,CS.Customerplanenddate
	FROM  #TempXMLData TmpAlias (NOLOCK) -- updated order by Parshant on 22 June 14
	LEFT OUTER JOIN [TescoSubscription].[CustomerSubscription] CS(NOLOCK)  -- updated order by Parshant on 22 June 14
		ON TmpAlias.CustomerID = CS.CustomerID
		AND CS.Customerplanstartdate <= TmpAlias.UpdateDate
		And CS.Customerplanenddate >= TmpAlias.UpdateDate 
		LEFT OUTER JOIN [Tescosubscription].[SubscriptionPlan] SP (NOLOCK)
		ON CS.SubscriptionPlanID = SP.SubscriptionPlanID	
  
	)
	SELECT distinct C.CustomerID
			,C.CSVActivePlans
			,C.UpdateDate -- added by Parshant on 22 June 14
	FROM CTE C

	DROP TABLE #TempXMLData	
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerActiveSubscriptionsGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerActiveSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerNextRenewalPaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerNextRenewalPaymentDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerNextRenewalPaymentDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerNextRenewalPaymentDetailsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerNextRenewalPaymentDetailsGet] not dropped.',16,1)
			END
	END
GO
CREATE PROCEDURE [tescosubscription].[CustomerNextRenewalPaymentDetailsGet]
(
	@CustomerSubsID BIGINT
)
AS

/*

	Author:			Saminathan
	Date created:	02/04/2014
	Purpose:		Returns next payment details
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>
*/

	BEGIN
	
	  SET NOCOUNT ON	
	
		DECLARE @NextPlanID	INT,
		        @CustomerID BIGINT,
                @Suspended  TINYINT,
                @Active     TINYINT,
                @PendingStop TINYINT,
				@CouponPayment TINYINT,
				@CardPayment	TINYINT,
				@UpfrontPayment  TINYINT


        SELECT  @Suspended = 7,
                @Active = 8,
                @PendingStop = 11,
				@CouponPayment=2,
				@CardPayment=1,
				@UpfrontPayment =1
		
		
		SELECT @NextPlanID=COALESCE(SwitchTo,SubscriptionPlanID),
			   @CustomerID=CustomerID
			   FROM tescosubscription.CustomerSubscription WITH (NOLOCK)
			   WHERE CustomerSubscriptionID=@CustomerSubsID
			
		SELECT SP.SubscriptionPlanID AS PlanID,			
			   NextRenewalDate AS	'PlanStartDate',
			   PlanName,
			   PlanTenure,
			   PlanAmount,
			   SP.PaymentInstallmentID,
			   CASE WHEN SP.PaymentInstallmentID <> @UpfrontPayment 
               THEN ROUND(PlanAmount/PlanTenure,2)* InstallmentTenure ELSE NULL END 'InstallmentAmount'	
			   FROM tescosubscription.CustomerSubscription CS WITH (NOLOCK) 
			   INNER JOIN  tescosubscription.SubscriptionPlan SP WITH (NOLOCK)
			   ON SP.SubscriptionPlanID=@NextPlanID
			   INNER JOIN [tescosubscription].[PaymentInstallment] IP (NOLOCK)
			   ON SP.PaymentInstallmentID =IP.PaymentInstallmentID
			   WHERE CustomerSubscriptionID= @CustomerSubsID 
			   AND (SubscriptionStatus IN (@Suspended,@Active) OR (SwitchTo IS NOT NULL AND SubscriptionStatus=@PendingStop  ))
			

		SELECT PaymentModeID,
			   PaymentToken
			   FROM tescosubscription.CustomerPayment WITH (NOLOCK) 
			   WHERE CustomerID=@CustomerID AND ((PaymentModeID=@CouponPayment AND IsActive = 1 AND IsFirstPaymentDue = 1 ) 
			   OR (PaymentModeID=@CardPayment AND  IsActive = 1 ))

	
	END
GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerNextRenewalPaymentDetailsGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerNextRenewalPaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerNextRenewalPaymentDetailsGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerNextRenewalPaymentDetailsGet] not created.',16,1)
	END
GO









IF OBJECT_ID(N'[tescosubscription].[CustomerNotificationDetailsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerNotificationDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerNotificationDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerNotificationDetailsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerNotificationDetailsGet] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE	[tescosubscription].[CustomerNotificationDetailsGet] 
AS
--TO RE DO 
/*  Author:			Thulasi 
	Date created:	9 Aug 2011
	Purpose:		1)To check if any active subscriptions' payment card details are due to expire that month before 7 days of payment due date
					  and also to send a reminder mail for the payment due within 7 days.
					2)To send a Email to the customer after every successful or failed recurring payment.
	Behaviour:		1)Gets the Payment token of Customers associated with an Active Subscription before 7 days of payment due date
					2)Gets the Customer Subscription Updated Details after the Recurring Payment Process is completed.
	Usage:			Everyday
	Called by:		NotifyCustomerSubscription [SSIS Package]
	

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
     26 Aug 2011	Manjunathan						Email select based on flag	 
     15 Sep 2011	Thulasi							Remove hard coding of Channel name, 
													Removed Business. Business and Language is configurable in the SSIS config file.
	 16 Sep	2011	Thulasi							Not sending the status 'SystemFailure' for notifications.
	 19 Sep 2011	Thulasi							Remove Channel name, And Channel is configured in SSIS package
	 30 Sep 2011	Thulasi							Added the logic to calculate and send next renewal date in case the payment is made and update has not occurred.
	 06 Jan	2012	Manjunathan Raman				Added join to new table - payment history response
	 15 Jan 2013    Robin                           Added Switch logic and SwitchTo
	 25 Feb 2013    Robin                           Added logic to get old subscriptionplanid and CS.SwitchTo IS NOT NULL
*/

BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE
			 @CurrentDate DATETIME	
			,@NotifyPeriod TINYINT -- no. of days before which notification has to be sent for expired cards
			,@SuccessPaymentProcessStatus TINYINT 
			,@InProgressPaymentProcessStatus TINYINT 
			,@ActiveSubscriptionStatus TINYINT
			,@RecurringChannelID	TINYINT
			,@SystemFailureStatusID TINYINT
			,@PendingStopStatus TINYINT
				
			
 
	SELECT @NotifyPeriod = 7
		   ,@CurrentDate = GETDATE()	
		   ,@SuccessPaymentProcessStatus = 6 
		   ,@InProgressPaymentProcessStatus = 5	
		   ,@ActiveSubscriptionStatus = 8
		   ,@RecurringChannelID = 2	
		   ,@SystemFailureStatusID = 3
		   ,@PendingStopStatus=11		   
 --	hard coded values are stored in variables for ease of future changes if any.
	
	SELECT 
		  CS.[CustomerSubscriptionID] TransactionID, 
		  CS.CustomerID
		  ,CCM.CountryCode
		  ,CP.[PaymentToken] -- The Expiry date has to be extracted from the payment Token
		  ,CS.[SubscriptionPlanID] -- needed to get the right terms and conditions URL and other details are fetched from ID	
		  ,CS.NextRenewalDate AS [NextRenewalDate]
          ,CASE  
		   when (CS.SubscriptionStatus = @ActiveSubscriptionStatus and CS.SwitchTo IS NULL) then  'Expiry' 
	       when (CS.SubscriptionStatus = @ActiveSubscriptionStatus and CS.SwitchTo IS NOT NULL) then  'Switched' 
           when (CS.SubscriptionStatus = @PendingStopStatus ) then  'Switched-Pending Stop'  END StatusName
		  ,COALESCE(CS.SwitchTo, 0)	 SwitchTo
	FROM tescosubscription.CustomerSubscription CS
		JOIN tescosubscription.Customerpayment CP	ON CP.CustomerID =	CS.CustomerID
													AND CP.PaymentModeID=1
													AND CP.IsActive = 1
													AND CS.NextRenewalDate <= DATEADD(DAY, @NotifyPeriod, @CurrentDate)
                									AND CS.NextRenewalDate <> CS.EmailSentRenewalDate  --check flag 
													AND CS.NextRenewalDate <  CS.CustomerPlanEndDate -- no notification is needed if the subscription is about to end
													AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus or (CS.SubscriptionStatus = @PendingStopStatus and CS.SwitchTo IS NOT NULL))
		JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
		JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID
		
	UNION   

	SELECT 		 
           CPH.CustomerPaymentHistoryID TransactionID
		  ,CS.CustomerID
		  ,CCM.CountryCode
    	  ,'' AS [PaymentToken]
		  ,CS.[SubscriptionPlanID]
          ,CASE CS.PaymentProcessStatus
					WHEN @InProgressPaymentProcessStatus 
					THEN DATEADD(m,SP.PlanTenure+datediff(m,CS.RenewalReferenceDate,CS.NextRenewalDate), CS.RenewalReferenceDate) 
					ELSE CS.NextRenewalDate END
		  ,CASE WHEN (CS.SwitchCustomerSubscriptionID IS NOT NULL AND SM.StatusId=1 ) THEN 'Switched-' + SM.StatusName Else  SM.StatusName END  StatusName
		  ,COALESCE(Source_CS.[SubscriptionPlanID],0) SwitchTo
		  
	FROM tescosubscription.CustomerPaymentHistory CPH
		JOIN tescosubscription.CustomerPaymentHistoryResponse CPHR ON CPHR.CustomerPaymentHistoryID=CPH.CustomerPaymentHistoryID
							AND IsEmailSent = 0 -- check flag
							AND ChannelID = @RecurringChannelID
          
		JOIN tescosubscription.CustomerSubscription CS         ON CPH.CustomerSubscriptionID	=	CS.CustomerSubscriptionID	
        LEFT JOIN tescosubscription.CustomerSubscription Source_CS  ON  CS.SwitchCustomerSubscriptionID =Source_CS.CustomerSubscriptionID
        JOIN tescosubscription.SubscriptionPlan SP		       ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
		JOIN tescosubscription.CountryCurrencyMap CCM	       ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID
		JOIN tescosubscription.StatusMaster SM			       ON  SM.StatusId		=	CPHR.PaymentStatusID 
														       AND	SM.StatusID <> @SystemFailureStatusID
		 
END


GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerNotificationDetailsGet] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerNotificationDetailsGet]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerNotificationDetailsGet] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerNotificationDetailsGet] not created.',16,1)
		END
	GO
IF OBJECT_ID(N'[tescosubscription].[CustomerNotificationDetailsGet1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CustomerNotificationDetailsGet1] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerNotificationDetailsGet1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerNotificationDetailsGet1]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerNotificationDetailsGet1]  not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE	[tescosubscription].[CustomerNotificationDetailsGet1] 
AS
--TO RE DO 
/*  Author:			Thulasi 
	Date created:	9 Aug 2011
	Purpose:		1)To check if any active subscriptions' payment card details are due to expire that month before 7 days of payment due date
					  and also to send a reminder mail for the payment due within 7 days.
					2)To send a Email to the customer after every successful or failed recurring payment.
	Behaviour:		1)Gets the Payment token of Customers associated with an Active Subscription before 7 days of payment due date
					2)Gets the Customer Subscription Updated Details after the Recurring Payment Process is completed.
	Usage:			Everyday
	Called by:		NotifyCustomerSubscription [SSIS Package]
	

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
     26 Aug 2011	Manjunathan						Email select based on flag	 
     15 Sep 2011	Thulasi							Remove hard coding of Channel name, 
													Removed Business. Business and Language is configurable in the SSIS config file.
	 16 Sep	2011	Thulasi							Not sending the status 'SystemFailure' for notifications.
	 19 Sep 2011	Thulasi							Remove Channel name, And Channel is configured in SSIS package
	 30 Sep 2011	Thulasi							Added the logic to calculate and send next renewal date in case the payment is made and update has not occurred.
     10 Jan 2013    Robin                           Added logic For plan Switch
     25 Feb 2013    Robin                           Added logic to get old subscriptionplanid and CS.SwitchTo IS NOT NULL
     10 Jun 2013    Robin                           Changed the version and added logic for montly card expiry and versioned
     
*/

BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE
			 @CurrentDate DATETIME	
			,@NotifyPeriod TINYINT -- no. of days before which notification has to be sent for expired cards
			,@SuccessPaymentProcessStatus TINYINT 
			,@InProgressPaymentProcessStatus TINYINT 
			,@ActiveSubscriptionStatus TINYINT
			,@RecurringChannelID	TINYINT
			,@SystemFailureStatusID TINYINT
			,@PendingStopStatus TINYINT
				
			
 
	SELECT @NotifyPeriod = 7
		   ,@CurrentDate = GETDATE()	
		   ,@SuccessPaymentProcessStatus = 6 
		   ,@InProgressPaymentProcessStatus = 5	
		   ,@ActiveSubscriptionStatus = 8
		   ,@RecurringChannelID = 2	
		   ,@SystemFailureStatusID = 3
		   ,@PendingStopStatus=11		   
 --	hard coded values are stored in variables for ease of future changes if any.
	
	SELECT 
		  CS.[CustomerSubscriptionID] TransactionID, 
		  CS.CustomerID
		  ,CCM.CountryCode
		  ,CP.[PaymentToken] -- The Expiry date has to be extracted from the payment Token
		  ,CS.[SubscriptionPlanID] -- needed to get the right terms and conditions URL and other details are fetched from ID	
		  ,CS.NextRenewalDate AS [NextRenewalDate]
          ,CASE  
		   WHEN (CS.SwitchTo IS NULL) then  'Payment Reminder' 
	       WHEN (CS.SubscriptionStatus = @PendingStopStatus ) then  'Switched-Pending Stop' 
	       ELSE 'Switched'  END StatusName
           ,COALESCE(CS.SwitchTo, 0)	 SwitchTo
	FROM tescosubscription.CustomerSubscription CS
		JOIN tescosubscription.Customerpayment CP	ON CP.CustomerID =	CS.CustomerID
													AND CP.PaymentModeID=1
													AND CP.IsActive = 1
													AND CS.NextRenewalDate <= DATEADD(DAY, @NotifyPeriod, @CurrentDate)
                									AND CS.NextRenewalDate <> CS.EmailSentRenewalDate  --check flag 
													AND (CS.NextRenewalDate <  CONVERT(DATETIME,CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101) ) 
															OR CS.SwitchTo IS NOT NULL) -- no notification is needed if the subscription is about to end
													AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus OR 
                                                        (CS.SubscriptionStatus = @PendingStopStatus AND CS.SwitchTo IS NOT NULL))
                                                    
		JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
													AND SP.PaymentInstallmentID = 1
		JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID
				
	UNION ALL  

    SELECT 
		  CS.[CustomerSubscriptionID] TransactionID, 
		  CS.CustomerID
		  ,CCM.CountryCode
		  ,CP.[PaymentToken] -- The Expiry date has to be extracted from the payment Token
		  ,CS.[SubscriptionPlanID] -- needed to get the right terms and conditions URL and other details are fetched from ID	
		  ,CS.NextRenewalDate AS [NextRenewalDate]
          ,CASE	WHEN (CS.SwitchTo IS NULL) then  'Payment Reminder' -- Status Pending stop and Active
				WHEN (CS.SubscriptionStatus = @PendingStopStatus And CS.SwitchTo IS NOT NULL) then  'Switched-Pending Stop'
				ELSE  'Switched' END StatusName
		  ,COALESCE(CS.SwitchTo, 0)	 SwitchTo
    FROM tescosubscription.CustomerSubscription CS
		JOIN tescosubscription.Customerpayment CP	ON CP.CustomerID =	CS.CustomerID
													AND CP.PaymentModeID=1
													AND CP.IsActive = 1
													AND CS.NextPaymentDate <= DATEADD(DAY, @NotifyPeriod, @CurrentDate)
                									AND CS.NextPaymentDate <> CS.EmailSentRenewalDate  --check flag 
													AND (CS.NextPaymentDate  <  CONVERT(DATETIME,CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101)) -- no notification is needed if the subscription is about to end
															OR CS.SwitchTo IS NOT NULL)
													AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus or CS.SubscriptionStatus = @PendingStopStatus )
		JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
													AND SP.PaymentInstallmentID <> 1
		JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID

   UNION ALL

	SELECT 		 
           CPH.CustomerPaymentHistoryID TransactionID
		  ,CS.CustomerID
		  ,CCM.CountryCode
    	  ,'' AS [PaymentToken]
		  ,CS.[SubscriptionPlanID]
          ,CASE CS.PaymentProcessStatus
					WHEN @InProgressPaymentProcessStatus 
					THEN DATEADD(m,SP.PlanTenure+datediff(m,CS.RenewalReferenceDate,CS.NextRenewalDate), CS.RenewalReferenceDate) 
					ELSE CS.NextRenewalDate END
		,CASE WHEN (CS.SwitchCustomerSubscriptionID IS NOT NULL AND SM.StatusId=1 
			AND CONVERT(VARCHAR(10),CPH.UTCCreatedDateTime,101) = CONVERT(VARCHAR(10),CS.UTCCreatedDateTime,101)) 
				THEN 'Switched-' + SM.StatusName Else  SM.StatusName END  StatusName
		  ,CASE WHEN (CS.SwitchCustomerSubscriptionID IS NOT NULL 
			AND CONVERT(VARCHAR(10),CPH.UTCCreatedDateTime,101) = CONVERT(VARCHAR(10),CS.UTCCreatedDateTime,101) ) 
				THEN Source_CS.[SubscriptionPlanID] Else 0 END	SwitchTo
		  
		  
	FROM tescosubscription.CustomerPaymentHistory CPH
		JOIN tescosubscription.CustomerPaymentHistoryResponse CPHR ON CPHR.CustomerPaymentHistoryID=CPH.CustomerPaymentHistoryID
							AND IsEmailSent = 0 -- check flag
							AND ChannelID = @RecurringChannelID
          
		JOIN tescosubscription.CustomerSubscription CS         ON CPH.CustomerSubscriptionID	=	CS.CustomerSubscriptionID	
        LEFT JOIN tescosubscription.CustomerSubscription Source_CS  ON  CS.SwitchCustomerSubscriptionID =Source_CS.CustomerSubscriptionID		
        JOIN tescosubscription.SubscriptionPlan SP		       ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
		JOIN tescosubscription.CountryCurrencyMap CCM	       ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID
		JOIN tescosubscription.StatusMaster SM			       ON  SM.StatusId		=	CPHR.PaymentStatusID 
														       AND	SM.StatusID <> @SystemFailureStatusID
        ORDER BY CS.CustomerID
		 
END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerNotificationDetailsGet1]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CustomerNotificationDetailsGet1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerNotificationDetailsGet1]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerNotificationDetailsGet1]  not created.',16,1)
		
	END
GO




set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go



ALTER PROCEDURE [tescosubscription].[CustomerNotificationDetailsGet2] 
AS
 
/*  Author:			Thulasi 
	Date created:	9 Aug 2011
	Purpose:		1)To check if any active subscriptions' payment card details are due to expire that month before 7 days of payment due date
					  and also to send a reminder mail for the payment due within 7 days.
					2)To send a Email to the customer after every successful or failed recurring payment.
	Behaviour:		1)Gets the Payment token of Customers associated with an Active Subscription before 7 days of payment due date
					2)Gets the Customer Subscription Updated Details after the Recurring Payment Process is completed.
	Usage:			Everyday
	Called by:		NotifyCustomerSubscription [SSIS Package]
	

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
     26 Aug 2011	Manjunathan						Email select based on flag	 
     15 Sep 2011	Thulasi							Remove hard coding of Channel name, 
													Removed Business. Business and Language is configurable in the SSIS config file.
	 16 Sep	2011	Thulasi							Not sending the status 'SystemFailure' for notifications.
	 19 Sep 2011	Thulasi							Remove Channel name, And Channel is configured in SSIS package
	 30 Sep 2011	Thulasi							Added the logic to calculate and send next renewal date in case the payment is made and update has not occurred.
     10 Jan 2013    Robin                           Added logic For plan Switch
     25 Feb 2013    Robin                           Added logic to get old subscriptionplanid and CS.SwitchTo IS NOT NULL
     10 Jun 2013    Robin                           Changed the version and added logic for montly card expiry and versioned
     20 May 2013    Deepmala                        Versioned and changed as per D7 release 
     2 March 2015   Robin                           Added the logic to pick the 7 days reminder email isted of 6 days
*/

BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE
			 @CurrentDate DATETIME	
			,@NotifyPeriod TINYINT -- no. of days before which notification has to be sent for expired cards
			,@SuccessPaymentProcessStatus TINYINT 
			,@InProgressPaymentProcessStatus TINYINT 
			,@ActiveSubscriptionStatus TINYINT
			,@RecurringChannelID	TINYINT
			,@SystemFailureStatusID TINYINT
			,@PendingStopStatus TINYINT
				
			
 
	SELECT @NotifyPeriod = 7
		   ,@CurrentDate = GETDATE()	
		   ,@SuccessPaymentProcessStatus = 6 
		   ,@InProgressPaymentProcessStatus = 5	
		   ,@ActiveSubscriptionStatus = 8
		   ,@RecurringChannelID = 2	
		   ,@SystemFailureStatusID = 3
		   ,@PendingStopStatus=11		   
 --	hard coded values are stored in variables for ease of future changes if any.
	
	SELECT 
		  CS.[CustomerSubscriptionID] TransactionID, 
		  CS.CustomerID
		  ,CCM.CountryCode
		  ,CP.[PaymentToken] -- The Expiry date has to be extracted from the payment Token
		  ,CS.[SubscriptionPlanID] -- needed to get the right terms and conditions URL and other details are fetched from ID	
		  ,CS.NextRenewalDate AS [NextRenewalDate]
          ,CASE  
		   WHEN (CS.SwitchTo IS NULL) then  'Payment Reminder' 
	       WHEN (CS.SubscriptionStatus = @PendingStopStatus ) then  'Switched-Pending Stop' 
	       ELSE 'Switched'  END StatusName
           ,COALESCE(CS.SwitchTo, 0)	 SwitchTo
	FROM tescosubscription.CustomerSubscription CS
		JOIN tescosubscription.Customerpayment CP	ON CP.CustomerID =	CS.CustomerID
													AND CP.PaymentModeID=1
													AND CP.IsActive = 1
                                                    AND CS.NextRenewalDate <= CONVERT(DATETIME,CONVERT(VARCHAR(10),DATEADD(DAY, @NotifyPeriod, @CurrentDate),101)+' 23:59:59')
												 -- AND CS.NextRenewalDate <= DATEADD(DAY, @NotifyPeriod, @CurrentDate)
                									AND CS.NextRenewalDate <> CS.EmailSentRenewalDate  --check flag 
													AND (CS.NextRenewalDate <  CONVERT(DATETIME,CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101) ) 
															OR CS.SwitchTo IS NOT NULL) -- no notification is needed if the subscription is about to end
													AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus OR 
                                                        (CS.SubscriptionStatus = @PendingStopStatus AND CS.SwitchTo IS NOT NULL))
                                                    
		JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
													AND SP.PaymentInstallmentID = 1
		JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID
				
	UNION ALL  

    SELECT 
		  CS.[CustomerSubscriptionID] TransactionID, 
		  CS.CustomerID
		  ,CCM.CountryCode
		  ,CP.[PaymentToken] -- The Expiry date has to be extracted from the payment Token
		  ,CS.[SubscriptionPlanID] -- needed to get the right terms and conditions URL and other details are fetched from ID	
		  ,CS.NextRenewalDate AS [NextRenewalDate]
          ,CASE	WHEN (CS.SwitchTo IS NULL) then  'Payment Reminder' -- Status Pending stop and Active
				WHEN (CS.SubscriptionStatus = @PendingStopStatus And CS.SwitchTo IS NOT NULL) then  'Switched-Pending Stop'
				ELSE  'Switched' END StatusName
		  ,COALESCE(CS.SwitchTo, 0)	 SwitchTo
    FROM tescosubscription.CustomerSubscription CS
		JOIN tescosubscription.Customerpayment CP	ON CP.CustomerID =	CS.CustomerID
													AND CP.PaymentModeID=1
													AND CP.IsActive = 1
                                                  --AND CS.NextPaymentDate <= DATEADD(DAY, @NotifyPeriod, @CurrentDate)
													AND CS.NextPaymentDate <= CONVERT(DATETIME,CONVERT(VARCHAR(10),DATEADD(DAY, @NotifyPeriod,@CurrentDate),101)+' 23:59:59')
                									AND CS.NextPaymentDate <> CS.EmailSentRenewalDate  --check flag 
													AND (CS.NextPaymentDate  <  CONVERT(DATETIME,CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101)) -- no notification is needed if the subscription is about to end
															OR CS.SwitchTo IS NOT NULL)
													AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus or CS.SubscriptionStatus = @PendingStopStatus )
		JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
													AND SP.PaymentInstallmentID <> 1
		JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID

       ORDER BY CS.CustomerID
	 
END



IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CustomerPaymentDetailsGet] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentDetailsGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentDetailsGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentDetailsGet] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerPaymentDetailsGet]
(
	@CustomerSubsID BIGINT
)
AS

/*

	Author:			Apoorva Shivakumar
	Date created:	05/08/2011
	Purpose:		Returns Customer Payment Details
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>
	--exec [tescosubscription].[CustomerPaymentDetailsGet] 26,''
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	09 Aug 2011      Apoorva						Added 	remarks column 
	27 Dec 2011		Ramesh CH						Joined with newly created table CustomerPaymentHistoryResponse for remarks and paymentstatus

*/

	BEGIN
	
	  SET NOCOUNT ON		
	
		SELECT 
			ph.CustomerPaymentID,
			ph.PaymentAmount,
			--ph.PaymentStatusID,
			ph.PaymentDate, 
			cp.IsActive,
			CPHR.Remarks,
			cp.PaymentToken,
			SM.StatusName
		from  tescosubscription.CustomerPaymentHistory ph (NOLOCK)
		INNER JOIN tescosubscription.CustomerPaymentHistoryResponse CPHR ON CPHR.CustomerPaymentHistoryID=ph.CustomerPaymentHistoryID
			AND ph.CustomerSubscriptionID=@CustomerSubsID
		INNER JOIN tescosubscription.CustomerPayment cp (NOLOCK) ON cp.CustomerPaymentID=ph.CustomerPaymentID
		INNER JOIN tescosubscription.StatusMaster  SM (NOLOCK) ON CPHR.PaymentStatusID=SM.StatusId
		ORDER BY  ph.UTCUpdatedDateTime desc
	END
	



	

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentDetailsGet]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentDetailsGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentDetailsGet] not created.',16,1)
		
	END
GOIF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [subscription].[CustomerPaymentHistoryEmailFlagUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [subscription].[CustomerPaymentHistoryEmailFlagUpdate] not dropped.',16,1)
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]
(
	--INPUT PARAMETERS HERE--
	@TransactionID as varchar(Max)
)
AS

/*

	Author:			Manjunathan Raman
	Date created:	26 Aug 2011
	Purpose:		To update Email flag
	Behaviour:		This procedure is called from Appstore on receiving response from notification service
	Usage:			Often in batch
	Called by:		AppStore
	WarmUP Script:	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	
*/

BEGIN
	DECLARE @CurrentDate DATETIME,
			@chrind INT,
		    @Piece BIGINT	
	SET NOCOUNT ON

	
	CREATE  TABLE #TempPaymentHistory(TransactionID BIGINT)
	 
	SELECT @chrind = 1, @CurrentDate=GETUTCDATE()
	WHILE @chrind > 0
	BEGIN
		SELECT @chrind = CHARINDEX(',',@TransactionID)
		IF @chrind > 0
			SELECT @Piece = LEFT(@TransactionID,@chrind - 1)
		ELSE
			SELECT @Piece = @TransactionID
		INSERT #TempPaymentHistory(TransactionID) VALUES(@Piece)
		SELECT @TransactionID = RIGHT(@TransactionID,LEN(@TransactionID) - @chrind)
		IF LEN(@TransactionID) = 0 BREAK
	END

	UPDATE PayHist
		SET IsEmailSent=1,
			UTCUpdatedDateTime=@CurrentDate
	FROM
	 tescosubscription.CustomerPaymentHistory  PayHist
	JOIN #TempPaymentHistory TempTb
		ON TempTb.TransactionID=CustomerPaymentHistoryID
			
	DROP TABLE #TempPaymentHistory
			
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] not created.',16,1)
	END
GO
IF OBJECT_ID('[tescosubscription].[CustomerPaymentHistoryGet]', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE [tescosubscription].[CustomerPaymentHistoryGet]

	IF OBJECT_ID('[tescosubscription].[CustomerPaymentHistoryGet]', 'P') IS NOT NULL
		RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerPaymentHistoryGet] - NOT DROPPED',16,1)
	ELSE
		PRINT 'SUCCESS: Stored Procedure:[tescosubscription].[CustomerPaymentHistoryGet] - DROPPED'
END
GO

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON
go


CREATE PROCEDURE [tescosubscription].[CustomerPaymentHistoryGet]
(
	@CustomerSubscriptionID	BIGINT
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get Customer Payment Details Based on CustomerSubscriptionID
    Behaviour:  How does this procedure actually work
    Usage:      Called By Juvo     

	--Modifications History--
 	Changed On        Changed By  Defect  Changes  Change Description 
	14th July 2014    Robin                        Added condition not to fetch PreAuth Records as per new requirement.
	10th March 2015   Priyansh					   Changing the order of selection			
*/
BEGIN

	
		 SELECT  
           CP.[CustomerID]
		  ,CP.[PaymentModeID]
		  ,CP.[PaymentToken]
		  ,PH.[PaymentDate]
		  ,PH.[PaymentAmount]
		  ,HR.[PaymentStatusID]
		  ,HR.[Remarks]      
		 FROM [TescoSubscription].[CustomerPayment] CP WITH (NOLOCK)
		 LEFT JOIN [TescoSubscription].[CustomerPaymentHistory] PH WITH (NOLOCK)
		 ON CP.CustomerPaymentID = PH.CustomerPaymentID
		 LEFT JOIN [TescoSubscription].[CustomerPaymentHistoryResponse] HR WITH (NOLOCK)
		 ON HR.CustomerPaymentHistoryID = PH.CustomerPaymentHistoryID
		 WHERE CustomerSubscriptionID = @CustomerSubscriptionID AND IsPreAuth=0
		 ORDER BY PH.[PaymentDate] desc

      
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentHistoryGet] TO [SubsUser]
GO
-- Check Exists
IF OBJECT_ID('[tescosubscription].[CustomerPaymentHistoryGet]', 'P') IS NOT NULL
	PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerPaymentHistoryGet] - CREATED'
ELSE
	RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerPaymentHistoryGet] - NOT CREATED',16,1)
GO	




IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponseCreate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentHistoryResponseCreate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponseCreate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[CustomerPaymentHistoryResponseCreate]
(
		--INPUT PARAMETERS HERE--
	 @CustomerPaymentHistoryID				BIGINT
	,@StatusID						TINYINT
	,@Remarks						VARCHAR(100) 
    
)
AS

/*

	Author:			Joji Isac
	Date created:	26 dec 2011
	Purpose:		To insert the payment attempt result in table CustomerPaymentHistoryResponse
	Behaviour:		This procedure is called from Appstore on receiving response from CPS
	Usage:			Often in batch
	Called by:		AppStore
	WarmUP Script:	Execute [tescosubscription].[CustomerPaymentHistoryResponseCreate] 11,0,'Subscriptions'
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	*/

BEGIN
				
	SET NOCOUNT ON

	INSERT INTO [tescosubscription].[CustomerPaymentHistoryResponse]
			   ([CustomerPaymentHistoryID]
			   ,[PaymentStatusID]
			   ,[Remarks])
		 VALUES
			   (
				@CustomerPaymentHistoryID
			   ,@StatusID
			   ,@Remarks  )

	
END


GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentHistoryResponseCreate] TO [SubsUser]
GO



IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponseCreate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] not created.',16,1)
	END
GO


IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistorySave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentHistorySave]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistorySave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistorySave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistorySave] not dropped.',16,1)
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerPaymentHistorySave]
(
		--INPUT PARAMETERS HERE--
	 @CustomerPaymentID				BIGINT
	,@CustomerSubscriptionID		BIGINT
    ,@PaymentAmount					SMALLMONEY
	,@Channel						VARCHAR(20) 
)
AS

/*

	Author:			Rajendra Singh
	Date created:	20 Jun 2011
	Purpose:		To insert the status of the payment for each payment record in table CustomerPaymentHistory
	Behaviour:		This procedure is called from Appstore on receiving response from CPS
	Usage:			Often in batch
	Called by:		AppStore
	WarmUP Script:	Execute [tescosubscription].[CustomerPaymentHistorySave] 11,23456,1,'Success',10,'Subscriptions'
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	<14 Jul 2011>	<Thulasi>						< Changed @StatusID type as TINYINT from SMALLINT>
	<23 Jul 2011>	<Thulasi>						<Based on the Channel update the status, IsFirstPaymentDue as false in the CustomerPayment>
	25 Aug 2011		Manjunathan						Removed PreAuth Logic
	16 Sep 2011		Thulasi					        Channel type changed from char(3) to varchar(20)
	27 Sep 2011		Manjunathan						returns the INSERTED CustomerPaymentHistoryid
	27 Dec 2011		Ramesh CH						Removed columns paymentStatusID and Remarks from CustomerPaymentHistory
*/

BEGIN
	DECLARE @ChannelID							TINYINT
			,@CurrentDate						DATETIME
				
	SET NOCOUNT ON

	SELECT @CurrentDate = GETDATE()
		   ,@ChannelID=ChannelID 
    FROM tescosubscription.ChannelMaster WITH (NOLOCK) WHERE ChannelName=@Channel

		INSERT	INTO tescosubscription.CustomerPaymentHistory 
			(
				[CustomerPaymentID]
			   ,[CustomerSubscriptionID]  
			   ,[PaymentDate]
			   ,[PaymentAmount]
			   ,[ChannelID]
			) output INSERTED.CustomerPaymentHistoryid 
			
		VALUES	( @CustomerPaymentID, 
				  @CustomerSubscriptionID, 
		          @CurrentDate, 
		          @PaymentAmount, 
		          @ChannelID )
END



GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentHistorySave] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistorySave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistorySave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistorySave] not created.',16,1)
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistorySave1]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [tescosubscription].[CustomerPaymentHistorySave1]
    
    IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistorySave1]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistorySave1] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [tescosubscription].[CustomerPaymentHistorySave1] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [tescosubscription].[CustomerPaymentHistorySave1]
(
		--INPUT PARAMETERS HERE--
	 @CustomerPaymentID				BIGINT
	,@CustomerSubscriptionID		BIGINT
    ,@PaymentAmount					SMALLMONEY
	,@Channel						VARCHAR(20) 
	,@PackageExecutionHistoryId		BIGINT
	,@IsPreAuth						Bit
)
AS

/*

	Author:			Robin
	Date created:	20 Jun 2014
	Purpose:		To insert the status of the payment for each payment record in table CustomerPaymentHistory
	Behaviour:		This procedure is called from Appstore on receiving response from CPS
	Usage:			Often in batch
	Called by:		AppStore
	WarmUP Script:	 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	
*/

BEGIN
	DECLARE @ChannelID							TINYINT
			,@CurrentDate						DATETIME
				
	SET NOCOUNT ON

	SELECT @CurrentDate = GETDATE()
		   ,@ChannelID=ChannelID 
    FROM tescosubscription.ChannelMaster WITH (NOLOCK) WHERE ChannelName=@Channel

		
		INSERT	INTO tescosubscription.CustomerPaymentHistory 
			(
				[CustomerPaymentID]
			   ,[CustomerSubscriptionID]  
			   ,[PaymentDate]
			   ,[PaymentAmount]
			   ,[ChannelID]
				,[PackageExecutionHistoryId]
				,[IsPreAuth]
			) output INSERTED.CustomerPaymentHistoryid 
			
		VALUES	( 
				@CustomerPaymentID, 
				@CustomerSubscriptionID, 
		        @CurrentDate, 
		        @PaymentAmount, 
		        @ChannelID,
				case when @PackageExecutionHistoryId <= 0 then null	else @PackageExecutionHistoryId end,
				@IsPreAuth
			)
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentHistorySave1] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistorySave1]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistorySave1] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [tescosubscription].[CustomerPaymentHistorySave1] not created.',
        16,
        1
    )
END
GO



IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentSave]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentSave] not dropped.',16,1)
			END
	END
GO






CREATE PROCEDURE [tescosubscription].[CustomerPaymentSave] 
(
	@CustomerID					BIGINT
	,@PaymentModeID				TINYINT
	,@PaymentToken				NVARCHAR(44)
)
AS
/*  Author:			Rajendra Singh
	Date created:	22 July 2011
	Purpose:		Create a Customer Payment
	Behaviour:		Inserts a CustomerPayment Detail if it does not exist already and makes other Payment Detail specific to the Customer as Inactive
	Usage:			Whenever a customer Places a new Payment Detail
	Called by:		Appstore method CreateCustomerPayment
	WarmUP Script:	Execute [tescosubscription].[CustomerPaymentSave] 121334, 1, 'asdfaf'
--Modifications History--
	Changed On		Changed By			Defect Ref		Change Description
	25-Aug-2011		Manjunathan Raman					Insert as Inactive
	05-Nov-2013     Robin                               Added CAST for Payment Token
*/


BEGIN

	DECLARE		 @CustomerPaymentID	BIGINT

	SET NOCOUNT ON;	
		
		SELECT @CustomerPaymentID=CustomerPaymentID FROM [tescosubscription].[CustomerPayment]
		                WHERE CustomerID		=	@CustomerID
						AND		CAST(PaymentToken AS VARBINARY(90))	=	CAST(@PaymentToken AS VARBINARY(90))
						AND		PaymentModeID	=	@PaymentModeID
				
		IF  @@rowcount =0
		BEGIN	--##
--	Create record for customer payment and make this InActive.
		
				INSERT INTO [tescosubscription].[CustomerPayment]
				   (
						[CustomerID]
					   ,[PaymentModeID]
					   ,[PaymentToken]
				   )
				 OUTPUT inserted.CustomerPaymentID
				VALUES
				   (
						@CustomerID	
						,@PaymentModeID			
						,@PaymentToken
					)
			
	
		END		--##
		
	select @CustomerPaymentID CustomerPaymentID		
				
END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentSave] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentSave] not created.',16,1)
	END
GO
	IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate]',N'P') IS NOT NULL
		BEGIN

			DROP PROCEDURE [tescosubscription].[CustomerPaymentUpdate]

			IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate]',N'P') IS NULL
				BEGIN
					PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentUpdate] dropped.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentUpdate] not dropped.',16,1)
				END
		END
	GO






	CREATE PROCEDURE [tescosubscription].[CustomerPaymentUpdate] 
	(
		 @CustomerPaymentID				BIGINT
		,@PaymentAmount					SMALLMONEY
	)
	AS
	/*  Author:			Manjunathan Raman
		Date created:	25 Aug 2011
		Purpose:		Updates Customer Payment
		Behaviour:		Updates Customer Payment after successful Authorisation and makes other Payment Detail specific to the Customer as Inactive
		Usage:			Whenever a customer Places a new Payment Detail
		Called by:		Appstore method CreateCustomerPayment
		WarmUP Script:	Execute [tescosubscription].[CustomerPaymentUpdate] 121334, 1
	--Modifications History--
		Changed On		Changed By		Defect Ref		Change Description
		<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	
	*/


	BEGIN

		DECLARE		@CustomerID					BIGINT
					,@PaymentModeID				TINYINT 
					,@CurrentUTCDate		DATETIME
					,@errorDescription	NVARCHAR(2048)
					,@error				INT
					,@errorProcedure	SYSNAME
					,@errorLine			INT
					,@PreAuthAmount	SMALLMONEY
					
		SET NOCOUNT ON;	

		SELECT	@CurrentUTCDate = GETUTCDATE(),@PreAuthAmount = 2
				,@CustomerID=CustomerID,@PaymentModeID=PaymentModeID
		 FROM
			[tescosubscription].[CustomerPayment]
		WHERE CustomerPaymentID=@CustomerPaymentID
		
			
		BEGIN TRY
		BEGIN TRANSACTION PaymentUpdate

	-- make others inactive
			UPDATE	[tescosubscription].[CustomerPayment]
			SET		[IsActive]			=	0,
					UTCUpdatedDateTime  =   @CurrentUTCDate
  			WHERE	CustomerID			=	@CustomerID
			AND		PaymentModeID		=	@PaymentModeID	
		
			UPDATE	[tescosubscription].[CustomerPayment]
							SET		[IsActive]	=	1
							,@CustomerPaymentID=CustomerPaymentID
							,IsFirstPaymentDue = CASE WHEN @PaymentAmount > @PreAuthAmount THEN 0 ELSE IsFirstPaymentDue END
							,UTCUpdatedDateTime  =   @CurrentUTCDate
			FROM	[tescosubscription].[CustomerPayment]
							WHERE	CustomerPaymentID=@CustomerPaymentID
				
		COMMIT TRANSACTION PaymentUpdate
		END TRY
		BEGIN CATCH

		  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
					  , @error                = ERROR_NUMBER()
					  , @errorDescription     = ERROR_MESSAGE()
					  , @errorLine            = ERROR_LINE()
		  FROM  INFORMATION_SCHEMA.ROUTINES
		  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		 ROLLBACK TRANSACTION PaymentUpdate
		 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 
		END CATCH

				
	END
	GO
	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerPaymentUpdate] TO [SubsUser]

	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentUpdate] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentUpdate] not created.',16,1)
		END
	GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentUpdate1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentUpdate1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentUpdate1] not dropped.',16,1)
			END
	END
GO

	CREATE PROCEDURE [tescosubscription].[CustomerPaymentUpdate1] 
	(
		 @CustomerPaymentID				BIGINT
		,@PaymentAmount					SMALLMONEY
		,@IsPreAuth						Bit
	)
	AS
	/*  Author:			Deepmala
		Date created:	20 May 2014
		Purpose:		Updates Customer Payment
		Behaviour:		Updates Customer Payment after successful Authorisation and makes other Payment Detail specific to the Customer as Inactive
		Usage:			Whenever a customer Places a new Payment Detail
		Called by:		Appstore method CreateCustomerPayment
	
	--Modifications History--
		Changed On		Changed By		Defect Ref		Change Description
		<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
		20 May 2014		Deepmala Trivedi				Added a new parameter IsPreAuth to modify IsFirstPaymentDue flag
	*/


	BEGIN

		DECLARE		@CustomerID					BIGINT
					,@PaymentModeID				TINYINT 
					,@CurrentUTCDate		DATETIME
					,@errorDescription	NVARCHAR(2048)
					,@error				INT
					,@errorProcedure	SYSNAME
					,@errorLine			INT
					--,@PreAuthAmount	SMALLMONEY
					
		SET NOCOUNT ON;	

		SELECT	@CurrentUTCDate = GETUTCDATE()--,@PreAuthAmount = 2
				,@CustomerID=CustomerID,@PaymentModeID=PaymentModeID
		 FROM
			[tescosubscription].[CustomerPayment]
		WHERE CustomerPaymentID=@CustomerPaymentID
		
			
		BEGIN TRY
		BEGIN TRANSACTION PaymentUpdate

	-- make others inactive
			UPDATE	[tescosubscription].[CustomerPayment]
			SET		[IsActive]			=	0,
					UTCUpdatedDateTime  =   @CurrentUTCDate
  			WHERE	CustomerID			=	@CustomerID
			AND		PaymentModeID		=	@PaymentModeID	
		
			UPDATE	[tescosubscription].[CustomerPayment]
							SET		[IsActive]	=	1
							,@CustomerPaymentID=CustomerPaymentID
							,IsFirstPaymentDue = CASE WHEN (@PaymentAmount > 0 and @IsPreAuth = 0) THEN 0 ELSE IsFirstPaymentDue END
							,UTCUpdatedDateTime  =   @CurrentUTCDate
			FROM	[tescosubscription].[CustomerPayment]
							WHERE	CustomerPaymentID=@CustomerPaymentID
				
		COMMIT TRANSACTION PaymentUpdate
		END TRY
		BEGIN CATCH

		  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
					  , @error                = ERROR_NUMBER()
					  , @errorDescription     = ERROR_MESSAGE()
					  , @errorLine            = ERROR_LINE()
		  FROM  INFORMATION_SCHEMA.ROUTINES
		  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		 ROLLBACK TRANSACTION PaymentUpdate
		 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 
		END CATCH

				
	END
	
GO
	
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentUpdate1] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentUpdate1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentUpdate1] not created.',16,1)
	END
GO

USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]
( 
	@CustomerId BIGINT
)
AS
BEGIN
SET NOCOUNT ON;

	SELECT [CustomerSubscriptionId]
          ,[PaymentRemainingAmount] 
      FROM [tescosubscription].[CustomerPaymentRemainingDetail] WITH (NOLOCK)
      WHERE [CustomerSubscriptionId] = @CustomerId
END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] not created.',16,1)
	END
GO
USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]

		IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave] not dropped.',16,1)
			END
	END
GO
CREATE PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]
(
	 @CustomerId BIGINT
	,@CustomerSubscriptionID BIGINT	
	,@RemainingAmount MONEY	
)
AS
/*   
 Author:   Deepmala
 Date created: 29 Apr 2014 
 Purpose:  Delete the exiting record and insert a new entry in the table 
 Behaviour:  How does this procedure actually work  
 Usage:   Hourly/Often 
 Called by:  <SubscriptionService>  
  --Modifications History--  
 Changed On     Changed By     Defect Ref       Change Description  
 
 */

BEGIN
	SET NOCOUNT ON;	

	DECLARE
	 @errorDescription	NVARCHAR(2048)
	,@error				INT
	,@errorProcedure	SYSNAME
	,@errorLine			INT
 
    BEGIN TRY
 
BEGIN TRANSACTION
		

        DELETE RM
        FROM Tescosubscription.CustomerPaymentRemainingDetail RM WITH (NOLOCK)
        INNER JOIN TescoSubscription.CustomerSubscription CS WITH (NOLOCK)
        ON RM.CustomerSubscriptionID = CS.CustomerSubscriptionID
        WHERE CS.CustomerID = @CustomerID

        IF (@RemainingAmount > -1)

        BEGIN
		INSERT INTO tescosubscription.CustomerPaymentRemainingDetail
		(
			CustomerSubscriptionId
			,PaymentRemainingAmount
		)
		VALUES
		(
		@CustomerSubscriptionID
		,@RemainingAmount
		)

        END
COMMIT TRANSACTION 
		
	END TRY
	BEGIN CATCH

		 SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
					  , @error                = ERROR_NUMBER()
					  , @errorDescription     = ERROR_MESSAGE()
					  , @errorLine            = ERROR_LINE()
		 FROM  INFORMATION_SCHEMA.ROUTINES
		 WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		 ROLLBACK TRANSACTION 
		 
		 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 
	END CATCH


END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave] not created.',16,1)
	END
GO











IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionCreate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionCreate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionCreate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionCreate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionCreate] not dropped.',16,1)
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionCreate] 
(
	@CustomerID					BIGINT
	,@SubscriptionPlanID		INT
	,@CustomerPlanStartDate		DATETIME
	,@CustomerPlanEndDate		DATETIME
	,@SubscriptionStatus		TINYINT
)
AS
/*  Author:			Rajendra Singh
	Date created:	22 July 2011
	Purpose:		To create a new Customer subscription Entry
	Behaviour:		Inserts a new CustomerSubscription with an Active Status, assigns the next renewal date and returns the newly generated CustomerSubscriptionID
	Usage:			Whenever a customer Places an Order from the Subscription Website.
	Called by:		Appstore method CreateCustomerSubscription
	WarmUP Script:	Execute [tescosubscription].[CustomerSubscriptionCreate] 1, 1, '10/10/2010', '10/10/2011', 8
--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	26  08  2011	Joji			--				A record inserted into [CustomerSubscriptionHistory]
	13-Sep- 2011    Saritha Kommineni			  Added transaction and modified scope indentity to output clause
	19 Sep 2011		Manjunathan Raman			  Removed date column in CustomerSubscriptionHistory Insert	
	5  Jan 2012		Joji						  Added check for if any non - cancelled subs exists 
	12 Mar 2013     Robin                         Added Status for Switch 
*/
BEGIN
	
	SET NOCOUNT ON;

 BEGIN TRY

	DECLARE @FreePeriod		TINYINT
			,@PlanTenure	INT
			,@CustomerSubscriptionID BIGINT
            ,@errorDescription				    NVARCHAR(2048)
			,@error								INT
			,@errorProcedure					SYSNAME
			,@errorLine							INT
			,@SubscriptionStatusCancelled		TinyInt
 			,@SubscriptionStatusStopped		TinyInt
			,@SubscriptionStatusSwitched TINYINT
	SELECT	@FreePeriod		=	FreePeriod
			,@PlanTenure	=	PlanTenure
			,@SubscriptionStatusCancelled = 9  -- 9 status of cancelled subscription 
			,@SubscriptionStatusStopped = 10	
			,@SubscriptionStatusSwitched = 16	

	FROM	tescosubscription.SubscriptionPlan WITH (NOLOCK)
	WHERE	SubscriptionPlanID	=	@SubscriptionPlanID


DECLARE @SubsTemp TABLE (
 CustomerSubscriptionID BIGINT)

IF EXISTS (
	SELECT 1 FROM  [tescosubscription].[CustomerSubscription] WHERE
		[CustomerID] = @CustomerID  and [SubscriptionStatus] NOT IN (@SubscriptionStatusCancelled,
																	@SubscriptionStatusStopped
																	,@SubscriptionStatusSwitched)	
		)
	BEGIN 
		-- a recent sub exists so don't create a new one 
		SELECT -1 CustomerSubscriptionID

	END 

ELSE
	BEGIN
	BEGIN TRANSACTION
		INSERT INTO [tescosubscription].[CustomerSubscription]
			   (
					[CustomerID]
				   ,[SubscriptionPlanID]
				   ,[CustomerPlanStartDate]
				   ,[CustomerPlanEndDate]
				   ,[NextRenewalDate]
				   ,[SubscriptionStatus]
				   ,[RenewalReferenceDate]
				)
	   OUTPUT inserted.CustomerSubscriptionID INTO @SubsTemp
		 VALUES
			   (
					@CustomerID				
					,@SubscriptionPlanID		
					,@CustomerPlanStartDate		
					,@CustomerPlanEndDate			
					,CASE	@FreePeriod
							WHEN	0	THEN	DATEADD(m,( @PlanTenure ), @CustomerPlanStartDate )
							ELSE	DATEADD(m,( @FreePeriod ), @CustomerPlanStartDate )	END
					,@SubscriptionStatus		
					,CASE	@FreePeriod
							WHEN	0	THEN	@CustomerPlanStartDate
							ELSE	DATEADD(m,( @FreePeriod ), @CustomerPlanStartDate )	END
				)
		
		INSERT INTO [tescosubscription].[CustomerSubscriptionHistory]
			   ([CustomerSubscriptionID]
			   ,[SubscriptionStatus]
			   ,[Remarks])
		 OUTPUT inserted.CustomerSubscriptionID
		 SELECT
			   CustomerSubscriptionID
			   ,@SubscriptionStatus
			   ,'Created New subs'
		 FROM @SubsTemp
		
	COMMIT TRANSACTION
	END
END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

     ROLLBACK TRANSACTION 

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 

	END CATCH

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionCreate] TO [SubsUser]

GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionCreate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionCreate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionCreate] not created.',16,1)
	END
GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionCreate1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionCreate1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionCreate1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionCreate1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionCreate1] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionCreate1] 
(
	@CustomerID					BIGINT
	,@SubscriptionPlanID		INT
	,@CustomerPlanStartDate		DATETIME
	,@CustomerPlanEndDate		DATETIME
	,@SubscriptionStatus		TINYINT
)
AS
/*  Author:			Robin
	Date created:	09 MAY 2013
	Purpose:		To create a new Customer subscription Entry
	Behaviour:		Inserts a new CustomerSubscription with an Active Status, assigns the next renewal date and returns the newly generated CustomerSubscriptionID
	Usage:			Whenever a customer Places an Order from the Subscription Website.
	Called by:		Appstore method CreateCustomerSubscription
	WarmUP Script:	Execute [tescosubscription].[CustomerSubscriptionCreate1] 25,9, '05/08/2013', '05/08/2014', 8
	
--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	
*/
BEGIN
	
	SET NOCOUNT ON;

 BEGIN TRY

	DECLARE @FreePeriod		TINYINT
			,@PlanTenure	INT
			,@CustomerSubscriptionID BIGINT
            ,@errorDescription				    NVARCHAR(2048)
			,@error								INT
			,@errorProcedure					SYSNAME
			,@errorLine							INT
			,@SubscriptionStatusCancelled		TinyInt
 			,@SubscriptionStatusStopped		TinyInt
			,@SubscriptionStatusSwitched TINYINT
            ,@PaymentInstallmentID  TINYINT
            ,@InstallmentTenure TINYINT
             
	SELECT	@FreePeriod		=	SP.FreePeriod
			,@PlanTenure	=	SP.PlanTenure
			,@SubscriptionStatusCancelled = 9  -- 9 status of cancelled subscription 
			,@SubscriptionStatusStopped = 10	
			,@SubscriptionStatusSwitched = 16
            ,@InstallmentTenure  = IP.InstallmentTenure 
            ,@PaymentInstallmentID = SP.PaymentInstallmentID
	FROM	tescosubscription.SubscriptionPlan SP WITH (NOLOCK)
    INNER JOIN tescosubscription.PaymentInstallment IP WITH (NOLOCK) 
		ON SP.PaymentInstallmentID = IP.PaymentInstallmentID
	WHERE	SubscriptionPlanID	=	@SubscriptionPlanID

    

DECLARE @SubsTemp TABLE (
 CustomerSubscriptionID BIGINT)

IF EXISTS (
	SELECT 1 FROM  [tescosubscription].[CustomerSubscription] WHERE
		[CustomerID] = @CustomerID  and [SubscriptionStatus] NOT IN (@SubscriptionStatusCancelled,
																	@SubscriptionStatusStopped
																	,@SubscriptionStatusSwitched)	
		)
	BEGIN 
		-- a recent sub exists so don't create a new one 
		SELECT -1 CustomerSubscriptionID

	END 

ELSE
	BEGIN
	BEGIN TRANSACTION
		INSERT INTO [tescosubscription].[CustomerSubscription]
			   (
					[CustomerID]
				   ,[SubscriptionPlanID]
				   ,[CustomerPlanStartDate]
				   ,[CustomerPlanEndDate]
				   ,[NextRenewalDate]
				   ,[SubscriptionStatus]
				   ,[RenewalReferenceDate]
                   ,[NextPaymentDate]
                   
				)
	   OUTPUT inserted.CustomerSubscriptionID INTO @SubsTemp
		 VALUES
			   (
					@CustomerID				
					,@SubscriptionPlanID		
					,@CustomerPlanStartDate		
					,@CustomerPlanEndDate			
					,CASE	@FreePeriod
							WHEN	0	THEN	DATEADD(m,( @PlanTenure ), @CustomerPlanStartDate )
                            ELSE	DATEADD(m,( @FreePeriod ), @CustomerPlanStartDate )	END
					,@SubscriptionStatus		
					,CASE	@FreePeriod
							WHEN	0	THEN	@CustomerPlanStartDate
							ELSE	DATEADD(m,( @FreePeriod ), @CustomerPlanStartDate )	END
                    ,CASE WHEN @PaymentInstallmentID <> 1
							THEN DATEADD(m,(CASE WHEN @FreePeriod = 0 THEN @InstallmentTenure ELSE @FreePeriod END), @CustomerPlanStartDate )
                           ELSE NULL END
               )
		
		INSERT INTO [tescosubscription].[CustomerSubscriptionHistory]
			   ([CustomerSubscriptionID]
			   ,[SubscriptionStatus]
			   ,[Remarks])
		 OUTPUT inserted.CustomerSubscriptionID
		 SELECT
			   CustomerSubscriptionID
			   ,@SubscriptionStatus
			   ,'Created New subs'
		 FROM @SubsTemp
		
	COMMIT TRANSACTION
	END
END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

     ROLLBACK TRANSACTION 

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 

	END CATCH

END



GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionCreate1] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionCreate1]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionCreate1] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionCreate1] not created.',16,1)
		END
	GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionDetailsGet] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionDetailsGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionDetailsGet]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionDetailsGet]  not dropped.',16,1)
				
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionDetailsGet]
(
	@CustomerID BIGINT 
)
AS

/*

	Author:			Sheshgiri Balgi 
	Date created:	22/07/2011
	Purpose:		Returns Customer subscription Details	
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	03 Aug 2011		Saritha K						Added statusid in where condition to filter deactived subscriptions
	09 Aug 2011		Saritha K						Modified PlanName to PlanDescription and added statusid (9) in where condition to filter cancelled subscriptions
    24 Aug 2011		Saritha K						Added statusid (10) in where condition to cancel stopped subscriptions
    23 Sep 2011	    saritha K						Added Condition to filter subscription with status OrderInitiated
	12 Mar 2013     Robin                           Added Status for Switch
*/

BEGIN

  SET NOCOUNT ON		
	

SELECT
        cs.SubscriptionPlanID    'SubscriptiomPlanID',
		cs.CustomerPlanStartDate 'SubscriptionStartDate',
        cs.CustomerPlanEndDate	 'SubscriptionEndDate',
        sm.StatusName            'SubscriptionStatus', 				  
		(
		SELECT sp.SubscriptionID 'SubscriptionID',
               sp.PlanDescription  'PlanDescription',
               sp.PlanTenure     'PlanTenure',
               sp.PlanAmount     'PlanValue', 
               sp.IsActive       'IsActive', 
               sp.BasketValue    'BasketValue'              
		FROM tescosubscription.SubscriptionPlan sp 
		WHERE sp.SubscriptionPlanID = cs.SubscriptionPlanID
		FOR XML PATH(''),TYPE
		)'PlanDetails'
	FROM tescosubscription.CustomerSubscription cs
	JOIN  tescosubscription.StatusMaster sm  ON sm.StatusId = cs.SubscriptionStatus
	WHERE cs.CustomerID = @CustomerID AND sm.statusid not in (9,10,15,16) --Filter Stopped,OrderInitiated and Cancelled Subscription
	FOR XML PATH('CustomerSubscriptionDetails'),TYPE
		
END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionDetailsGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionDetailsGet]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionDetailsGet]  not created.',16,1)
		
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionEmailFlagUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionEmailFlagUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionEmailFlagUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate] not dropped.',16,1)
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionEmailFlagUpdate]
(
	--INPUT PARAMETERS HERE--
	@TransactionID as varchar(Max)
)
AS

/*

	Author:			Manjunathan Raman
	Date created:	26 Aug 2011
	Purpose:		To update Email flag
	Behaviour:		This procedure is called from Appstore on receiving response from notification service
	Usage:			Often in batch
	Called by:		AppStore
	WarmUP Script:	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	
*/

BEGIN
	DECLARE @CurrentDate  DATETIME,
			@chrind INT,
			@Piece BIGINT
				
	SET NOCOUNT ON



	CREATE  TABLE #TempCustomerSubscription(TransactionID BIGINT)

	SELECT @chrind = 1,@CurrentDate=GETUTCDATE()
	WHILE @chrind > 0
	BEGIN
		SELECT @chrind = CHARINDEX(',',@TransactionID)
		IF @chrind > 0
			SELECT @Piece = LEFT(@TransactionID,@chrind - 1)
		ELSE
			SELECT @Piece = @TransactionID
		INSERT #TempCustomerSubscription(TransactionID) VALUES(@Piece)
		SELECT @TransactionID = RIGHT(@TransactionID,LEN(@TransactionID) - @chrind)
		IF LEN(@TransactionID) = 0 BREAK
	END

	UPDATE CustSubs
		SET EmailSentRenewalDate=NextRenewalDate,
			UTCUpdatedDateTime=@CurrentDate
	FROM
	 tescosubscription.CustomerSubscription  CustSubs
	JOIN #TempCustomerSubscription TempTb
		ON TempTb.TransactionID=CustomerSubscriptionID
			
	DROP TABLE #TempCustomerSubscription
			
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionEmailFlagUpdate] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionEmailFlagUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate] not created.',16,1)
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionEmailFlagUpdate1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionEmailFlagUpdate1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionEmailFlagUpdate1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate1] not dropped.',16,1)
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionEmailFlagUpdate1]
(
	--INPUT PARAMETERS HERE--
	@TransactionID as varchar(Max)
)
AS

/*

	Author:			Manjunathan Raman
	Date created:	26 Aug 2011
	Purpose:		To update Email flag
	Behaviour:		This procedure is called from Appstore on receiving response from notification service
	Usage:			Often in batch
	Called by:		AppStore
	WarmUP Script:	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	26 Jun 2013     Robin                           Vesioned it and added logic to update NextPaymentDate to EmailSentRenewalDate
*/

BEGIN
	DECLARE @CurrentDate  DATETIME,
			@chrind INT,
			@Piece BIGINT,
            @UpfrontPayment TINYINT
				
	SET NOCOUNT ON



	CREATE  TABLE #TempCustomerSubscription(TransactionID BIGINT)

	SELECT @chrind = 1,@CurrentDate=GETUTCDATE(),@UpfrontPayment = 1
	WHILE @chrind > 0
	BEGIN
		SELECT @chrind = CHARINDEX(',',@TransactionID)
		IF @chrind > 0
			SELECT @Piece = LEFT(@TransactionID,@chrind - 1)
		ELSE
			SELECT @Piece = @TransactionID
		INSERT #TempCustomerSubscription(TransactionID) VALUES(@Piece)
		SELECT @TransactionID = RIGHT(@TransactionID,LEN(@TransactionID) - @chrind)
		IF LEN(@TransactionID) = 0 BREAK
	END

	UPDATE CustSubs
		SET EmailSentRenewalDate=CASE SP.PaymentInstallmentID WHEN @UpfrontPayment THEN NextRenewalDate ELSE NextPaymentDate END,
            UTCUpdatedDateTime=@CurrentDate
	FROM
	 tescosubscription.CustomerSubscription  CustSubs (NOLOCK)
     JOIN tescosubscription.SubscriptionPlan SP (NOLOCK)
        ON CustSubs.SubscriptionPlanID = SP.SubscriptionPlanID
	JOIN #TempCustomerSubscription TempTb
		ON TempTb.TransactionID=CustomerSubscriptionID
			
	DROP TABLE #TempCustomerSubscription
			
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionEmailFlagUpdate1] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionEmailFlagUpdate1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate1] not created.',16,1)
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionGet] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionGet]
	(@CustomerSubscriptionID BIGINT)
AS
/*
Author:		Robin
Create date: 10 - Feb - 2013
Purpose: To get the customer subscription
Called by:		DS and Juvo

--Modifications History--
Changed On		Changed By		Defect Ref		Change Description
 
*/

BEGIN	
	SET NOCOUNT ON;

	SELECT [CustomerSubscriptionID]
      ,[CustomerID]
      ,[SubscriptionPlanID]
      ,[CustomerPlanStartDate]
      ,[CustomerPlanEndDate]
      ,[NextRenewalDate]
      ,[SubscriptionStatus]
      ,[PaymentProcessStatus]
      ,[RenewalReferenceDate]
      ,[EmailSentRenewalDate]
      ,[UTCCreatedDateTime]
      ,[UTCUpdatedDateTime]
      ,[SwitchCustomerSubscriptionID]
      ,[SwitchTo]
	FROM [TescoSubscription].[tescosubscription].[CustomerSubscription](NOLOCK)
	WHERE [CustomerSubscriptionID] = @CustomerSubscriptionID
END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionGet] not created.',16,1)
	END
GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet1]',N'P') IS NOT NULL
		BEGIN

			DROP PROCEDURE [tescosubscription].[CustomerSubscriptionGet1]

			IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet1]',N'P') IS NULL
				BEGIN
					PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionGet1] dropped.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionGet1] not dropped.',16,1)
				END
		END
	GO
	

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionGet1]
	(@CustomerSubscriptionID BIGINT)
AS
/*
Author:		Robin
Create date: 10 - Feb - 2013
Purpose: To get the customer subscription
Called by:		DS

--Modifications History--
Changed On		Changed By		Defect Ref		Change Description
27 June 2013    RObin                           Versioned and added Logic for NextPaymentDate
*/

BEGIN	
	SET NOCOUNT ON;

	SELECT CS.[CustomerSubscriptionID]
      ,CS.[CustomerID]
      ,CS.[SubscriptionPlanID]
      ,CS.[CustomerPlanStartDate]
      ,CS.[CustomerPlanEndDate]
      ,CS.[NextRenewalDate]
      ,CS.[SubscriptionStatus]
      ,CS.[PaymentProcessStatus]
      ,CS.[RenewalReferenceDate]
      ,CS.[EmailSentRenewalDate]
      ,CS.[UTCCreatedDateTime]
      ,CS.[UTCUpdatedDateTime]
      ,CS.[SwitchCustomerSubscriptionID]
      ,CS.[SwitchTo]
      ,CS.[NextPaymentDate]
      ,CASE WHEN CS.NextPaymentDate IS NULL THEN 0 ELSE ISNULL(DATEDIFF(M,CS.NextPaymentDate,CS.NextRenewalDate)/IP.InstallmentTenure,0) END RemainingInstallments					
	FROM [TescoSubscription].[CustomerSubscription] CS(NOLOCK)
    INNER JOIN [Tescosubscription].[SubscriptionPlan] SP (NOLOCK)
    ON CS.SubscriptionPlanID = SP.SubscriptionPlanID
    INNER JOIN [Tescosubscription].[PaymentInstallment] IP (NOLOCK) 
    ON SP.PaymentInstallmentID = IP.PaymentInstallmentID
	WHERE CS.[CustomerSubscriptionID] = @CustomerSubscriptionID
END

GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionGet1] TO [SubsUser]
	GO

	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet1]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionGet1] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionGet1] not created.',16,1)
		END
	GO
USE [TescoSubscription]
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet2]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionGet2]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionGet2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionGet2] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionGet2]
	(@CustomerSubscriptionID BIGINT)
AS
/*
Author:		Robin
Create date: 10 - May - 2014
Purpose: To get the customer subscription
Called by:		DS
				 
--Modifications History--
Changed On		Changed By		Defect Ref		Change Description
*/

BEGIN	
	SET NOCOUNT ON;

	SELECT CS.[CustomerSubscriptionID]
      ,CS.[CustomerID]
      ,CS.[SubscriptionPlanID]
      ,CS.[CustomerPlanStartDate]
      ,CS.[CustomerPlanEndDate]
      ,CS.[NextRenewalDate]
      ,CS.[SubscriptionStatus]
      ,CS.[PaymentProcessStatus]
      ,CS.[RenewalReferenceDate]
      ,CS.[EmailSentRenewalDate]
      ,CS.[UTCCreatedDateTime]
      ,CS.[UTCUpdatedDateTime]
      ,CS.[SwitchCustomerSubscriptionID]
      ,CS.[SwitchTo]
      ,CS.[NextPaymentDate]
      ,CASE WHEN CS.NextPaymentDate IS NULL THEN 0 ELSE ISNULL(DATEDIFF(M,CS.NextPaymentDate,CS.NextRenewalDate)/IP.InstallmentTenure,0) END RemainingInstallments					
	FROM [TescoSubscription].[CustomerSubscription] CS(NOLOCK)
    INNER JOIN [Tescosubscription].[SubscriptionPlan] SP (NOLOCK)
    ON CS.SubscriptionPlanID = SP.SubscriptionPlanID
    INNER JOIN [Tescosubscription].[PaymentInstallment] IP (NOLOCK) 
    ON SP.PaymentInstallmentID = IP.PaymentInstallmentID
	WHERE CS.[CustomerSubscriptionID] = @CustomerSubscriptionID

	SELECT PaymentRemainingAmount FROM tescosubscription.CustomerPaymentRemainingDetail
	WHERE CustomerSubscriptionId = @CustomerSubscriptionID
END

	
GO
	
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionGet2] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet2]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionGet2] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionGet2] not created.',16,1)
	END
GO




IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistoryGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionHistoryGet] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistoryGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionHistoryGet]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionHistoryGet]  not dropped.',16,1)
				
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionHistoryGet]
(
	@CustomerSubscriptionID BIGINT	
)
AS

/*

	Author:			Thulasi Rangan
	Date created:	19/08/2011
	Purpose:		Returns Customer subscription History Details	
	Behaviour:		Fetches all the records in the Customer subscription History for the given subscription.
	Usage:			
	Called by:		
	Warm up script	exec [tescosubscription].[CustomerSubscriptionHistoryGet] 9

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	

*/

	BEGIN
	
	SET NOCOUNT ON
	
			SELECT [SubscriptionHistoryID]
				   ,CSH.[CustomerSubscriptionID]
		           ,SM.StatusName
		           ,CSH.UTCCreatedDateTime
				   ,[Remarks]
		           ,CS.CustomerID as [CustomerID]
		  FROM tescosubscription.CustomerSubscription CS 
		  INNER JOIN	[tescosubscription].[CustomerSubscriptionHistory] CSH ON CS.CustomerSubscriptionID = @CustomerSubscriptionID AND CSH.CustomerSubscriptionID = CS.CustomerSubscriptionID
		  INNER JOIN	tescosubscription.StatusMaster SM ON  CSH.SubscriptionStatus = SM.StatusId  
		  ORDER BY [SubscriptionHistoryID] ASC
	END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionHistoryGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistoryGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionHistoryGet]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionHistoryGet]  not created.',16,1)
		
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionLapsedPeriodGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionLapsedPeriodGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionLapsedPeriodGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] not dropped.',16,1)
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] 	
	@CustomerId BIGINT,
	@SubscriptionLapsedPeriod INT Output 	
AS
/*
	Author:		 Lavanya
	Create date: 04/10/2012
	Description: Get the customer subscription lapsed period

		--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	11-Oct-2012     Lavanya                          MOdified to new customer to use coupon
	25-Oct-2012	Manjunathan Raman		To handle False Cancelled Subscriptions (System Cancelled)


*/
BEGIN
	
	SET NOCOUNT ON;
	SELECT @SubscriptionLapsedPeriod = ISNULL(datediff(day, MAX(CustomerPlanEndDate), Getdate()),-1)
	FROM tescosubscription.CustomerSubscription CS (NOLOCK)
	JOIN tescosubscription.CustomerPaymentHistory CPH (NOLOCK)
	 ON  CPH.CustomerSubscriptionID=CS.CustomerSubscriptionID                                                                          
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR (NOLOCK)
	 ON  CPH.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID  
		AND PaymentStatusID=1
	WHERE 
		subscriptionstatus in (9,10)
		and CustomerID = @CustomerId

	/*
		9 - Cancelled
		10 - Stopped
	*/
END


GO

GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] TO [SubsUser] AS [dbo]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionLapsedPeriodGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] not created.',16,1)
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate] 
AS
/*  Author:			Rajendra Singh
	Date created:	21 Jun 2011
	Purpose:		To update the renewal date in  bulk based on the status inserted by the web service for the recently processed subscriptions.
	Behaviour:		Based on the Status received from the web service, updates the Next renewal date and processing status
	Usage:			Often in batch
	Called by:		Web Service
	WarmUP Script:	Execute [tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	<29 Jun 2011>	<Thulasi>						<Month Logic>
	<04 Jul 2011>	<Manju>							<New calculation logic in Month Logic,Added cases>
	<12 Jul 2011>	<Thulasi>						<Subscription Status in Customer Subscription>
	<25 Jul 2011>	<Thulasi>						<update the status, IsFirstPaymentDue as false in the CustomerPayment if it is true>
    <29 Aug 2011>    Rajendra						 Added logic to to insert SuspendedSubscription Status Customer subscription history 
    <30 Sep 2011>    <Thulasi>						 Renamed as CustomerSubscriptionNextRenewalBulkUpdate and is not used by the scheduler service.

*/
BEGIN
	DECLARE @SuccessPaymentProcessStatus TINYINT
            ,@InProgressPaymentProcessStatus TINYINT
			,@SuccessPaymentStatus TINYINT
			,@CardFailurePaymentStatus TINYINT
			,@SuspendedSubscriptionStatus TINYINT
			,@CurrentUTCDate DATETIME
			,@PreAuthAmount SMALLMONEY
			,@errorDescription				    NVARCHAR(2048)
			,@error								INT
			,@errorProcedure					SYSNAME
			,@errorLine							INT
	
	SET NOCOUNT ON;

   SELECT @SuccessPaymentProcessStatus = 6 ,@InProgressPaymentProcessStatus = 5,@CurrentUTCDate = GETUTCDATE(), @SuccessPaymentStatus = 1,
			@CardFailurePaymentStatus = 2, @SuspendedSubscriptionStatus = 7, @PreAuthAmount = 2
		
	BEGIN TRY

	CREATE TABLE #CustomerSubscriptionInProgress
	(CustomerPaymentHistoryID BIGINT)
	
	--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		
		
	INSERT INTO #CustomerSubscriptionInProgress
	SELECT MAX(CustomerPaymentHistoryID) CustomerPaymentHistoryID FROM  tescosubscription.CustomerSubscription CS  With (nolock)
	JOIN tescosubscription.CustomerPaymentHistory CPH 	With (nolock) ON CS.CustomerSubscriptionID=CPH.CustomerSubscriptionID 
													AND CS.PaymentProcessStatus = @InProgressPaymentProcessStatus
													AND CPH.PaymentDate > NextRenewalDate
					GROUP BY CPH.CustomerSubscriptionID
		
	BEGIN TRANSACTION UpdatePaymentAndSubscription
	
	UPDATE CS
										    -- Success Case
		SET CS.NextRenewalDate            =   CASE PaymentStatusID 
										WHEN @SuccessPaymentStatus 
										THEN DATEADD(m,SP.PlanTenure+datediff(m,CS.RenewalReferenceDate,CS.NextRenewalDate), CS.RenewalReferenceDate) 
										ELSE CS.NextRenewalDate END
												--    Card Failure
		 ,CS.SubscriptionStatus		=   CASE PaymentStatusID 
										WHEN @CardFailurePaymentStatus THEN  @SuspendedSubscriptionStatus
										ELSE CS.SubscriptionStatus END                                       
		 ,CS.PaymentProcessStatus      =     @SuccessPaymentProcessStatus
		 ,UTCUpdatedDateTime=@CurrentUTCDate
	FROM  #CustomerSubscriptionInProgress CPHLatest	
	JOIN  tescosubscription.CustomerPaymentHistory CPH ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID 
	JOIN tescosubscription.CustomerSubscription CS	ON  CPH.CustomerSubscriptionID=CS.CustomerSubscriptionID                                                                          
	JOIN  tescosubscription.SubscriptionPlan SP          ON    CS.SubscriptionPlanID         =      SP.SubscriptionPlanID
	WHERE CS.PaymentProcessStatus = @InProgressPaymentProcessStatus
	
	UPDATE	CP
		SET		CP.IsFirstPaymentDue = 0,UTCUpdatedDateTime=@CurrentUTCDate
	FROM  #CustomerSubscriptionInProgress CPHLatest
	JOIN tescosubscription.CustomerPaymentHistory CPH	ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID                                                                            
	JOIN tescosubscription.CustomerPayment CP			ON	CP.CustomerPaymentID	=	 CPH.CustomerPaymentID
		  WHERE CP.IsFirstPaymentDue = 1 
			--AND CPH.PaymentAmount > @PreAuthAmount 
			AND CPH.PaymentStatusID = @SuccessPaymentStatus
	
		
	COMMIT TRANSACTION UpdatePaymentAndSubscription
	
	/*Insert into Customer subscription history in case of SuspendedSubscription Status*/	
	INSERT INTO tescosubscription.CustomerSubscriptionHistory (CustomerSubscriptionID, SubscriptionStatus, Remarks)
	SELECT CustomerSubscriptionID, @SuspendedSubscriptionStatus, CPH.Remarks
	FROM  #CustomerSubscriptionInProgress CPHLatest
	JOIN tescosubscription.CustomerPaymentHistory CPH	ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID                                                                            
	WHERE CPH.PaymentStatusID = @CardFailurePaymentStatus
	
	END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

     ROLLBACK TRANSACTION UpdatePaymentAndSubscription

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 

	END CATCH

	DROP TABLE #CustomerSubscriptionInProgress
	
END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate] TO [SubsUser]
GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalBulkUpdate] not created.',16,1)
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalUpdate] 
@TransactionID as varchar(Max)
AS
/*  Author:			Rajendra Singh
	Date created:	21 Jun 2011
	Purpose:		To update the renewal date in  bulk based on the status inserted by the web service for the recently processed subscriptions.
	Behaviour:		Based on the Status received from the web service, updates the Next renewal date and processing status
	Usage:			Often in batch
	Called by:		Web Service
	WarmUP Script:	Execute [tescosubscription].[CustomerSubscriptionNextRenewalUpdate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	<29 Jun 2011>	<Thulasi>						<Month Logic>
	<04 Jul 2011>	<Manju>							<New calculation logic in Month Logic,Added cases>
	<12 Jul 2011>	<Thulasi>						<Subscription Status in Customer Subscription>
	<25 Jul 2011>	<Thulasi>						<update the status, IsFirstPaymentDue as false in the CustomerPayment if it is true>
    <29 Aug 2011>   <Rajendra>						 Added logic to to insert SuspendedSubscription Status Customer subscription history 
    <27 Sep 2011>	<Manjunathan>					<Takes an input of comma separated transaction IDs.update based on the transaction IDs>
	06 Jan	2012	Manjunathan Raman				Added changes to incorporate new table - payment history response
*/
BEGIN
	DECLARE @SuccessPaymentProcessStatus TINYINT
            ,@InProgressPaymentProcessStatus TINYINT
			,@SuccessPaymentStatus TINYINT
			,@CardFailurePaymentStatus TINYINT
			,@SuspendedSubscriptionStatus TINYINT
			,@CurrentUTCDate DATETIME
			,@PreAuthAmount SMALLMONEY
			,@errorDescription				    NVARCHAR(2048)
			,@error								INT
			,@errorProcedure					SYSNAME
			,@errorLine							INT
			,@chrind INT
			,@Piece BIGINT
	
		SET NOCOUNT ON;

   SELECT @SuccessPaymentProcessStatus = 6 ,@InProgressPaymentProcessStatus = 5,@CurrentUTCDate = GETUTCDATE(), @SuccessPaymentStatus = 1,
			@CardFailurePaymentStatus = 2, @SuspendedSubscriptionStatus = 7, @PreAuthAmount = 2,@chrind = 1
		
	BEGIN TRY
	
	CREATE  TABLE #CustomerSubscriptionInProgress(CustomerPaymentHistoryID BIGINT)

	WHILE @chrind > 0
	BEGIN
		SELECT @chrind = CHARINDEX(',',@TransactionID)
		IF @chrind > 0
			SELECT @Piece = LEFT(@TransactionID,@chrind - 1)
		ELSE
			SELECT @Piece = @TransactionID
		INSERT #CustomerSubscriptionInProgress(CustomerPaymentHistoryID) VALUES(@Piece)
		SELECT @TransactionID = RIGHT(@TransactionID,LEN(@TransactionID) - @chrind)
		IF LEN(@TransactionID) = 0 BREAK
	END

	BEGIN TRANSACTION UpdatePaymentAndSubscription
	UPDATE CS
										  -- Success Case
		SET CS.NextRenewalDate      =   CASE PaymentStatusID 
										WHEN @SuccessPaymentStatus 
										THEN DATEADD(m,SP.PlanTenure+datediff(m,CS.RenewalReferenceDate,CS.NextRenewalDate), CS.RenewalReferenceDate) 
										ELSE CS.NextRenewalDate END
												--    Card Failure
		 ,CS.SubscriptionStatus		=   CASE PaymentStatusID 
										WHEN @CardFailurePaymentStatus THEN  @SuspendedSubscriptionStatus
										ELSE CS.SubscriptionStatus END                                       
		 ,CS.PaymentProcessStatus   =   @SuccessPaymentProcessStatus
		 ,UTCUpdatedDateTime=@CurrentUTCDate
	FROM  #CustomerSubscriptionInProgress CPHLatest	
	JOIN  tescosubscription.CustomerPaymentHistory CPH ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID 
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR ON  CPHLatest.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID 
	JOIN tescosubscription.CustomerSubscription CS	ON  CPH.CustomerSubscriptionID=CS.CustomerSubscriptionID                                                                          
	JOIN  tescosubscription.SubscriptionPlan SP          ON    CS.SubscriptionPlanID         =      SP.SubscriptionPlanID
	WHERE CS.PaymentProcessStatus = @InProgressPaymentProcessStatus  -- this check will prevent double updates in case the service retries
	
	UPDATE	CP
		SET		CP.IsFirstPaymentDue = 0,UTCUpdatedDateTime=@CurrentUTCDate
	FROM  #CustomerSubscriptionInProgress CPHLatest
	JOIN tescosubscription.CustomerPaymentHistory CPH	ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID                                                                            
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR ON  CPHLatest.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID 
	JOIN tescosubscription.CustomerPayment CP			ON	CP.CustomerPaymentID	=	 CPH.CustomerPaymentID
    WHERE CP.IsFirstPaymentDue = 1 
	AND CPHR.PaymentStatusID = @SuccessPaymentStatus
	
		
	COMMIT TRANSACTION UpdatePaymentAndSubscription
	
	--Insert into Customer subscription history in case of SuspendedSubscription Status
	INSERT INTO tescosubscription.CustomerSubscriptionHistory (CustomerSubscriptionID, SubscriptionStatus, Remarks)
	SELECT CustomerSubscriptionID, @SuspendedSubscriptionStatus, CPHR.Remarks
	FROM  #CustomerSubscriptionInProgress CPHLatest
	JOIN tescosubscription.CustomerPaymentHistory CPH	ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID                                                                            
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR ON  CPHLatest.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID 
	WHERE CPHR.PaymentStatusID = @CardFailurePaymentStatus
	
	END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

     ROLLBACK TRANSACTION UpdatePaymentAndSubscription

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)

	END CATCH

	DROP TABLE #CustomerSubscriptionInProgress
	
END



GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionNextRenewalUpdate] TO [SubsUser]
GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate] not created.',16,1)
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1] not dropped.',16,1)
			END
	END 
GO



CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1] 
@TransactionID as varchar(Max)
AS
/*  Author:			Robin John
	Date created:	29 May 2013
	Purpose:		To update the renewal date in  bulk based on the status inserted by the web service for the recently processed subscriptions.
	Behaviour:		Based on the Status received from the web service, updates the Next renewal date and processing status
	Usage:			Often in batch
	Called by:		Web Service
	WarmUP Script:	Execute [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	27 Jun 2013     Robin                            Versioned and added logic for NextPaymentDate
*/
BEGIN
	DECLARE @SuccessPaymentProcessStatus TINYINT
            ,@InProgressPaymentProcessStatus TINYINT
			,@SuccessPaymentStatus TINYINT
			,@CardFailurePaymentStatus TINYINT
			,@SuspendedSubscriptionStatus TINYINT
			,@CurrentUTCDate DATETIME
			,@PreAuthAmount SMALLMONEY
			,@errorDescription				    NVARCHAR(2048)
			,@error								INT
			,@errorProcedure					SYSNAME
			,@errorLine							INT
			,@chrind INT
			,@Piece BIGINT
	
		SET NOCOUNT ON;

   SELECT @SuccessPaymentProcessStatus = 6 ,@InProgressPaymentProcessStatus = 5,@CurrentUTCDate = GETUTCDATE(), @SuccessPaymentStatus = 1,
			@CardFailurePaymentStatus = 2, @SuspendedSubscriptionStatus = 7, @PreAuthAmount = 2,@chrind = 1
		
	BEGIN TRY
	
	CREATE  TABLE #CustomerSubscriptionInProgress(CustomerPaymentHistoryID BIGINT)

	WHILE @chrind > 0
	BEGIN
		SELECT @chrind = CHARINDEX(',',@TransactionID)
		IF @chrind > 0
			SELECT @Piece = LEFT(@TransactionID,@chrind - 1)
		ELSE
			SELECT @Piece = @TransactionID
		INSERT #CustomerSubscriptionInProgress(CustomerPaymentHistoryID) VALUES(@Piece)
		SELECT @TransactionID = RIGHT(@TransactionID,LEN(@TransactionID) - @chrind)
		IF LEN(@TransactionID) = 0 BREAK
	END

	BEGIN TRANSACTION UpdatePaymentAndSubscription
	UPDATE CS
										  -- Success Case
		SET CS.NextRenewalDate      =   CASE    
										WHEN PaymentStatusID = @SuccessPaymentStatus AND IP.PaymentInstallmentID = 1
										THEN DATEADD(m,SP.PlanTenure+DATEDIFF(M,CS.RenewalReferenceDate,CS.NextRenewalDate), CS.RenewalReferenceDate) 
										WHEN PaymentStatusID = @SuccessPaymentStatus AND IP.PaymentInstallmentID <> 1  AND DATEDIFF(d,CS.NextRenewalDate,CS.NextPaymentDate) >= 0
                                        THEN DATEADD(m,SP.PlanTenure+DATEDIFF(M,CS.RenewalReferenceDate,CS.NextRenewalDate), CS.RenewalReferenceDate) 
                                        ELSE CS.NextRenewalDate END
												--    Card Failure
		 ,CS.SubscriptionStatus		=   CASE PaymentStatusID 
										WHEN @CardFailurePaymentStatus THEN  @SuspendedSubscriptionStatus
										ELSE CS.SubscriptionStatus END                                       
		 ,CS.PaymentProcessStatus   =   @SuccessPaymentProcessStatus
		 ,UTCUpdatedDateTime=@CurrentUTCDate
         ,CS.NextPaymentDate        =  CASE 
                                       WHEN PaymentStatusID = @SuccessPaymentStatus AND IP.PaymentInstallmentID <>1
                                       THEN DATEADD(M,IP.InstallmentTenure+DATEDIFF(M,CS.RenewalReferenceDate,CS.NextPaymentDate), CS.RenewalReferenceDate)
                                       ELSE CS.NextPaymentDate END
                                             

	FROM  #CustomerSubscriptionInProgress CPHLatest	
	JOIN  tescosubscription.CustomerPaymentHistory CPH ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID 
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR ON  CPHLatest.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID 
	JOIN tescosubscription.CustomerSubscription CS	ON  CPH.CustomerSubscriptionID=CS.CustomerSubscriptionID                                                                          
	JOIN  tescosubscription.SubscriptionPlan SP          ON    CS.SubscriptionPlanID         =      SP.SubscriptionPlanID
    JOIN tescosubscription.PaymentInstallment IP ON   SP.PaymentInstallmentID  =  IP.PaymentInstallmentID
	WHERE CS.PaymentProcessStatus = @InProgressPaymentProcessStatus  -- this check will prevent double updates in case the service retries
	
	UPDATE	CP
		SET		CP.IsFirstPaymentDue = 0,UTCUpdatedDateTime=@CurrentUTCDate
	FROM  #CustomerSubscriptionInProgress CPHLatest
	JOIN tescosubscription.CustomerPaymentHistory CPH	ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID                                                                            
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR ON  CPHLatest.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID 
	JOIN tescosubscription.CustomerPayment CP			ON	CP.CustomerPaymentID	=	 CPH.CustomerPaymentID
    WHERE CP.IsFirstPaymentDue = 1 
	AND CPHR.PaymentStatusID = @SuccessPaymentStatus
	
		
	COMMIT TRANSACTION UpdatePaymentAndSubscription
	
	--Insert into Customer subscription history in case of SuspendedSubscription Status
	INSERT INTO tescosubscription.CustomerSubscriptionHistory (CustomerSubscriptionID, SubscriptionStatus, Remarks)
	SELECT CustomerSubscriptionID, @SuspendedSubscriptionStatus, CPHR.Remarks
	FROM  #CustomerSubscriptionInProgress CPHLatest
	JOIN tescosubscription.CustomerPaymentHistory CPH	ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID                                                                            
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR ON  CPHLatest.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID 
	WHERE CPHR.PaymentStatusID = @CardFailurePaymentStatus
	
	END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

     ROLLBACK TRANSACTION UpdatePaymentAndSubscription

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)

	END CATCH

	DROP TABLE #CustomerSubscriptionInProgress
	
END


GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate1]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1] not created.',16,1)
		END
	GO

USE tescoSubscription
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate2]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] not dropped.',16,1)
			END
	END
GO

GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] 
@TransactionID as varchar(Max)
AS
/*  Author:			Robin John
	Date created:	29 May 2013
	Purpose:		To update the renewal date in  bulk based on the status inserted by the web service for the recently processed subscriptions.
	Behaviour:		Based on the Status received from the web service, updates the Next renewal date and processing status
	Usage:			Often in batch
	Called by:		Web Service
	WarmUP Script:	Execute [tescosubscription].[CustomerSubscriptionNextRenewalUpdate1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	27 Jun 2013     Robin                            Versioned and added logic for NextPaymentDate
*/
BEGIN
	DECLARE @SuccessPaymentProcessStatus TINYINT
            ,@InProgressPaymentProcessStatus TINYINT
			,@SuccessPaymentStatus TINYINT
			,@CardFailurePaymentStatus TINYINT
			,@SuspendedSubscriptionStatus TINYINT
			,@CurrentUTCDate DATETIME
			,@PreAuthAmount SMALLMONEY
			,@errorDescription				    NVARCHAR(2048)
			,@error								INT
			,@errorProcedure					SYSNAME
			,@errorLine							INT
			,@chrind INT
			,@Piece BIGINT
	
		SET NOCOUNT ON;

   SELECT @SuccessPaymentProcessStatus = 6 ,@InProgressPaymentProcessStatus = 5,@CurrentUTCDate = GETUTCDATE(), @SuccessPaymentStatus = 1,
			@CardFailurePaymentStatus = 2, @SuspendedSubscriptionStatus = 7, @PreAuthAmount = 2,@chrind = 1
		
	BEGIN TRY
	
	CREATE  TABLE #CustomerSubscriptionInProgress(CustomerPaymentHistoryID BIGINT)

	WHILE @chrind > 0
	BEGIN
		SELECT @chrind = CHARINDEX(',',@TransactionID)
		IF @chrind > 0
			SELECT @Piece = LEFT(@TransactionID,@chrind - 1)
		ELSE
			SELECT @Piece = @TransactionID
		INSERT #CustomerSubscriptionInProgress(CustomerPaymentHistoryID) VALUES(@Piece)
		SELECT @TransactionID = RIGHT(@TransactionID,LEN(@TransactionID) - @chrind)
		IF LEN(@TransactionID) = 0 BREAK
	END

	BEGIN TRANSACTION UpdatePaymentAndSubscription
	UPDATE CS
										  -- Success Case
		SET CS.NextRenewalDate      =   CASE    
										WHEN PaymentStatusID = @SuccessPaymentStatus AND IP.PaymentInstallmentID = 1
										THEN DATEADD(m,SP.PlanTenure+DATEDIFF(M,CS.RenewalReferenceDate,CS.NextRenewalDate), CS.RenewalReferenceDate) 
										WHEN PaymentStatusID = @SuccessPaymentStatus AND IP.PaymentInstallmentID <> 1  AND DATEDIFF(d,CS.NextRenewalDate,CS.NextPaymentDate) >= 0
                                        THEN DATEADD(m,SP.PlanTenure+DATEDIFF(M,CS.RenewalReferenceDate,CS.NextRenewalDate), CS.RenewalReferenceDate) 
                                        ELSE CS.NextRenewalDate END
												--    Card Failure
		 ,CS.SubscriptionStatus		=   CASE PaymentStatusID 
										WHEN @CardFailurePaymentStatus THEN  @SuspendedSubscriptionStatus
										ELSE CS.SubscriptionStatus END                                       
		 ,CS.PaymentProcessStatus   =   @SuccessPaymentProcessStatus
		 ,UTCUpdatedDateTime=@CurrentUTCDate
         ,CS.NextPaymentDate        =  CASE 
                                       WHEN PaymentStatusID = @SuccessPaymentStatus AND IP.PaymentInstallmentID <>1
                                       THEN DATEADD(M,IP.InstallmentTenure+DATEDIFF(M,CS.RenewalReferenceDate,CS.NextPaymentDate), CS.RenewalReferenceDate)
                                       ELSE CS.NextPaymentDate END
                                             

	FROM  #CustomerSubscriptionInProgress CPHLatest	
	JOIN  tescosubscription.CustomerPaymentHistory CPH ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID 
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR ON  CPHLatest.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID 
	JOIN tescosubscription.CustomerSubscription CS	ON  CPH.CustomerSubscriptionID=CS.CustomerSubscriptionID                                                                          
	JOIN  tescosubscription.SubscriptionPlan SP          ON    CS.SubscriptionPlanID         =      SP.SubscriptionPlanID
    JOIN tescosubscription.PaymentInstallment IP ON   SP.PaymentInstallmentID  =  IP.PaymentInstallmentID
	WHERE CS.PaymentProcessStatus = @InProgressPaymentProcessStatus  -- this check will prevent double updates in case the service retries
	
	
		
	COMMIT TRANSACTION UpdatePaymentAndSubscription
	
	--Insert into Customer subscription history in case of SuspendedSubscription Status
	INSERT INTO tescosubscription.CustomerSubscriptionHistory (CustomerSubscriptionID, SubscriptionStatus, Remarks)
	SELECT CustomerSubscriptionID, @SuspendedSubscriptionStatus, CPHR.Remarks
	FROM  #CustomerSubscriptionInProgress CPHLatest
	JOIN tescosubscription.CustomerPaymentHistory CPH	ON  CPHLatest.CustomerPaymentHistoryID	   =     CPH.CustomerPaymentHistoryID                                                                            
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR ON  CPHLatest.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID 
	WHERE CPHR.PaymentStatusID = @CardFailurePaymentStatus
	
	END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

     ROLLBACK TRANSACTION UpdatePaymentAndSubscription

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)

	END CATCH

	DROP TABLE #CustomerSubscriptionInProgress
	
END

GO
	
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate2]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] not created.',16,1)
	END
GO



IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] not dropped.',16,1)
			END
	END
GO




/****** Object:  StoredProcedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]    Script Date: 06/28/2011 12:35:08 ******/
CREATE	PROCEDURE	[tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] 
(
	--INPUT PARAMETERS HERE--
	@PackageExecutionHistoryID BIGINT
)
AS
/*  Author:			Manjunathan Raman
	Date created:	21 Jun 2011
	Purpose:		To update batches of Subscriptions to success status
	Behaviour:		 update batches of Subscriptions to success status during failure in SSIS package
	Usage:			Often in batch
	Called by:		DataFlow task in RenewCustomerSubscriptions [SSIS Package]
	

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	06 Jan	2012	Manjunathan Raman				Changes to incorporate column "PackageExecutionHistoryID" moved to customerPaymentHistory table

*/

BEGIN
	SET NOCOUNT ON
	-- Declare a table variable to get the desired customer subscriptions

	DECLARE @CurrentUTCDate DATETIME	
			,@SuccessPaymentProcessStatus TINYINT 
			,@InProgressPaymentProcessStatus TINYINT
 -- Set today's date with time set to end of day.
	SELECT @CurrentUTCDate = GETUTCDATE()	
		   ,@SuccessPaymentProcessStatus = 6 	
		   ,@InProgressPaymentProcessStatus = 5
		
	--Update the status to Success
		UPDATE	CS
		SET		CS.PaymentProcessStatus =	@SuccessPaymentProcessStatus 
				,CS.UTCUpdatedDateTime	=	@CurrentUTCDate
		FROM [tescosubscription].CustomerPaymentHistory CPH
		JOIN tescosubscription.CustomerSubscription CS 
			ON CPH.PackageExecutionHistoryID=@PackageExecutionHistoryID
			AND CS.CustomerSubscriptionID = CPH.CustomerSubscriptionID
			AND CS.PaymentProcessStatus=@InProgressPaymentProcessStatus

END



GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] not created.',16,1)
	END
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPlanGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionPlanGet] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPlanGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionPlanGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionPlanGet] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionPlanGet] 
(
     @CustomerID BIGINT,
     @BusinessTypeId TINYINT,
     @DeliveryTypeId TINYINT  
)

AS
/*
Author:			Robin
Date created:	12/12/2012
Purpose:		Returns the subscription details for a customer based upon Business, Delivery type and CustomerId
Behaviour:		How does this procedure actually work
Usage:			
Called by:		<DS>
exec [tescosubscription].[CustomerSubscriptionPlanGet] 

--Modifications History--
	Changed On		Changed By		Defect Ref		                                Change Description
	12/06/2012       Robin	         Correction ** Create Procedure
	
*/
BEGIN
	   
	SET NOCOUNT ON

	CREATE TABLE #TempPlanGet
	(PlanName VARCHAR(50),BasketValue SMALLMONEY, PlanDescription varchar(255), StatusName VARCHAR(20)
	,StatusID TINYINT,CustomerPlanStartDate DATETIME,CustomerPlanEndDate DATETIME
	,SubscriptionPlanID INT,ISSlotRestricted BIT) 

	INSERT #TempPlanGet 	
	SELECT TOP 1
		SP.Planname,
		SP.BasketValue,
		SP.PlanDescription,
		SN.StatusName,
		SN.StatusId,
		CS.CustomerPlanStartDate,
		CS.CustomerPlanEndDate,
		SP.SubscriptionPlanID,
		SP.ISSlotRestricted	   
	FROM [Tescosubscription].[CustomerSubscription] CS (NOLOCK)  
	INNER JOIN [Tescosubscription].[SubscriptionPlan] SP (NOLOCK)
	ON CS.SubscriptionPlanID  = SP.SubscriptionPlanID
	INNER JOIN [Tescosubscription].[StatusMaster] SN (NOLOCK)
	ON CS.SubscriptionStatus = SN.StatusID
	WHERE CS.Customerid = @CustomerID
	AND SP.BusinessID = @BusinessTypeId
	AND SP.SubscriptionID = @DeliveryTypeId
	ORDER BY CS.CustomerPlanStartDate desc
	--AND CS.SubscriptionStatus in (8,11) 					


	SELECT
		SubscriptionPlanID,
		Planname,
		PlanDescription,
		BasketValue,
		StatusName,
		StatusId,
		CustomerPlanStartDate,
		CustomerPlanEndDate,
		ISSlotRestricted
	FROM #TempPlanGet

	IF (SELECT ISSlotRestricted FROM #TempPlanGet) = 1
	BEGIN
		SELECT 
			DOW
		FROM #TempPlanGet SubsPlan  
		INNER JOIN [Tescosubscription].[SubscriptionPlanSlot] Slot (NOLOCK)  
		ON SubsPlan.SubscriptionPlanID  = Slot.SubscriptionPlanID
		ORDER BY DOW
	END


	DROP TABLE #TempPlanGet		 

END 


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionPlanGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPlanGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionPlanGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionPlanGet] not created.',16,1)
		
	END
GO










	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet]',N'P') IS NOT NULL
		BEGIN

			DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsDueRenewalGet]

			IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet]',N'P') IS NULL
				BEGIN
					PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet] dropped.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet] not dropped.',16,1)
				END
		END
	GO

	CREATE	PROCEDURE	[tescosubscription].[CustomerSubscriptionsDueRenewalGet] 
	(
		--INPUT PARAMETERS HERE--
		@BatchSize INT
		,@PackageExecutionHistoryID BIGINT
	)
	AS
	/*  Author:			Rajendra Singh
		Date created:	21 Jun 2011
		Purpose:		To fetch batches of Subscriptions to be renewed and initiate the payment transactions
		Behaviour:		Fetches a batch of renewal customers, initiates the payment and retrieves the data as needed by the web service to process the payment.
		Usage:			Often in batch
		Called by:		DataFlow task in RenewCustomerSubscriptions [SSIS Package]
	

		--Modifications History--
		Changed On		Changed By		Defect Ref		Change Description
		<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
		15 Sep 2011		Thulasi							Remove hard coding of Channel name, 
														Removed Business. Business and Language is configurable in the SSIS config file.
		16 Sep 2011		<Thulasi>						<Channel type changed from char(3) to varchar(20)>
		19 Sep 2011		Manjunathan R					Introduced Insert to log table
		06 Jan	2012	Manjunathan Raman				Added join to new table - payment history response
	
	*/

	BEGIN
		SET NOCOUNT ON
		-- Declare a table variable to get the desired customer subscriptions

		DECLARE	@Subs		TABLE
		(
			 CustomerSubscriptionID	BIGINT UNIQUE
			,CustomerID				BIGINT
			,Region					CHAR(2)		
			,PaymentToken			NVARCHAR(44)
			,PlanAmount				SMALLMONEY
			,CustomerPaymentID		BIGINT
			,IsFirstPaymentDue      BIT
		)

		DECLARE @EndOfDay DATETIME
				,@CurrentUTCDate DATETIME	
				,@SuccessPaymentProcessStatus TINYINT 
				,@InProgressPaymentProcessStatus TINYINT
				,@ActiveSubscriptionStatus TINYINT
				,@WebChannel VARCHAR(20)
				,@RecurringChannel VARCHAR(20)
				,@WebChannelID TINYINT
				,@RecurringChannelID	TINYINT
				,@CreatedDate Datetime

	 
		SELECT
		        @EndOfDay = CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE(), 101) + ' 23:59:59') 	 -- Set today's date with time set to end of day.
			   ,@CurrentUTCDate = GETUTCDATE()	
			 -- Below Assigned values are status Id reference data from status master table
			   ,@SuccessPaymentProcessStatus = 6 	
			   ,@InProgressPaymentProcessStatus = 5
			   ,@ActiveSubscriptionStatus = 8
			   ,@WebChannelID = 1	-- channel id for first time payment for a particular card through scheduler
			   ,@RecurringChannelID = 2	  -- channel id for recurring payment through scheduler
			   ,@CreatedDate = GETDATE()
		   
		SELECT @WebChannel = ChannelName FROM tescosubscription.ChannelMaster WITH (NOLOCK) WHERE ChannelID =  @WebChannelID
	
		SELECT @RecurringChannel = ChannelName FROM tescosubscription.ChannelMaster WITH (NOLOCK) WHERE ChannelID =  @RecurringChannelID
	

	 --	hard coded values are stored in variables for ease of future changes if any.
   
	
		INSERT INTO @Subs
		(
			CustomerSubscriptionID	
			,CustomerID			
			,Region								
			,PaymentToken	
			,PlanAmount	
			,CustomerPaymentID	
			,IsFirstPaymentDue	
		)
		SELECT TOP (@BatchSize)
			   CS.[CustomerSubscriptionID]
			  ,CS.CustomerID
			  ,CCM.CountryCode
			  ,CP.[PaymentToken]
			  ,SP.[PlanAmount]	
			  ,CP.CustomerPaymentID
			  ,IsFirstPaymentDue
		FROM tescosubscription.CustomerSubscription CS
			JOIN tescosubscription.Customerpayment CP		ON  CP.CustomerID	=	CS.CustomerID
															AND CP.PaymentModeID=1
															AND CP.IsActive = 1
															AND CS.PaymentProcessStatus = @SuccessPaymentProcessStatus
															AND CS.NextRenewalDate <= @EndOfDay
															AND CS.NextRenewalDate <  CS.CustomerPlanEndDate
															AND CS.SubscriptionStatus = @ActiveSubscriptionStatus
			JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
			JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID

		--Insert INTO CustomerPaymentHistory table
		INSERT INTO [Tescosubscription].[CustomerPaymentHistory]
			   (CustomerPaymentID
				,CustomerSubscriptionID
				,PaymentDate
				,PaymentAmount
				,ChannelID
				,PackageExecutionHistoryID)
		SELECT
			CustomerPaymentID
			,CustomerSubscriptionID	
			,@CreatedDate
			,PlanAmount
			,@RecurringChannelID
			,@PackageExecutionHistoryID
		FROM @Subs
	
		--Update the status as InProgress
			
		UPDATE	CS
			SET		CS.PaymentProcessStatus =	@InProgressPaymentProcessStatus  -- Update the status to be in progress
					,CS.UTCUpdatedDateTime	=	@CurrentUTCDate
		FROM @Subs Subs
			INNER JOIN	tescosubscription.CustomerSubscription CS ON Subs.CustomerSubscriptionID = CS.CustomerSubscriptionID
	

	--The following details are sent to the Scheduler Service
		SELECT
			 CustomerPaymentHistoryID
			,[CustomerID]
			,[Region]
			,[PaymentToken]
			,[PlanAmount]
			-- For cards whose first payment is due, 'Web' is used as the Channel to accomodate RONo requirements.
			-- But in the CustomerPaymentHistory, 'Subscriptions' is recorded as the channel after the payment.
			,CASE	
					WHEN	IsFirstPaymentDue = 1	THEN @WebChannel
					ELSE	@RecurringChannel END AS 'Channel'
		FROM	@Subs Subs
		JOIN [Tescosubscription].[CustomerPaymentHistory] CH
			ON CH.CustomerSubscriptionID=Subs.CustomerSubscriptionID
		WHERE 
			PackageExecutionHistoryID=@PackageExecutionHistoryID

	END


GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsDueRenewalGet] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet] not created.',16,1)
		END
	GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsDueRenewalGet1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet1] not dropped.',16,1)
			END
	END 
GO


	CREATE	PROCEDURE	[tescosubscription].[CustomerSubscriptionsDueRenewalGet1] 
	(
		--INPUT PARAMETERS HERE--
		@BatchSize INT
		,@PackageExecutionHistoryID BIGINT
	)
	AS
	/*  Author:			Robin
		Date created:	29 May 2013
		Purpose:		To fetch batches of Subscriptions to be renewed and initiate the payment transactions
		Behaviour:		Fetches a batch of renewal customers, initiates the payment and retrieves the data as needed by the web service to process the payment.
		Usage:			Often in batch
		Called by:		DataFlow task in RenewCustomerSubscriptions [SSIS Package]
	

		--Modifications History--
		Changed On		Changed By		Defect Ref		Change Description
	
	
	*/

	BEGIN
		SET NOCOUNT ON
		-- Declare a table variable to get the desired customer subscriptions

				DECLARE	@Subs		TABLE
		(
			 CustomerSubscriptionID	BIGINT UNIQUE
			,CustomerID				BIGINT
			,Region					CHAR(2)		
			,PaymentToken			NVARCHAR(44)
			,PlanAmount				SMALLMONEY
			,CustomerPaymentID		BIGINT
			,IsFirstPaymentDue      BIT
		)
       

		DECLARE @EndOfDay DATETIME
				,@CurrentUTCDate DATETIME	
				,@SuccessPaymentProcessStatus TINYINT 
				,@InProgressPaymentProcessStatus TINYINT
				,@ActiveSubscriptionStatus TINYINT
				,@PendingStopSubscriptionStatus TINYINT
				,@WebChannel VARCHAR(20)
				,@RecurringChannel VARCHAR(20)
				,@WebChannelID TINYINT
				,@RecurringChannelID	TINYINT
				,@CreatedDate Datetime

	 
		SELECT
		        @EndOfDay = CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE(), 101) + ' 23:59:59') 	 -- Set today's date with time set to end of day.
			   ,@CurrentUTCDate = GETUTCDATE()	
			 -- Below Assigned values are status Id reference data from status master table
			   ,@SuccessPaymentProcessStatus = 6 	
			   ,@InProgressPaymentProcessStatus = 5
			   ,@ActiveSubscriptionStatus = 8
			   ,@PendingStopSubscriptionStatus = 11
			   ,@WebChannelID = 1	-- channel id for first time payment for a particular card through scheduler
			   ,@RecurringChannelID = 2	  -- channel id for recurring payment through scheduler
			   ,@CreatedDate = GETDATE()
		   
		SELECT @WebChannel = ChannelName FROM tescosubscription.ChannelMaster WITH (NOLOCK) WHERE ChannelID =  @WebChannelID
	
		SELECT @RecurringChannel = ChannelName FROM tescosubscription.ChannelMaster WITH (NOLOCK) WHERE ChannelID =  @RecurringChannelID
	

		--	hard coded values are stored in variables for ease of future changes if any.
		--Below query is to get the upfront processing records only.
	
		INSERT INTO @Subs
		(
			CustomerSubscriptionID	
			,CustomerID			
			,Region								
			,PaymentToken	
			,PlanAmount	
			,CustomerPaymentID	
			,IsFirstPaymentDue	
		)
		SELECT TOP (@BatchSize) 
			   CS.[CustomerSubscriptionID]
			  ,CS.CustomerID
			  ,CCM.CountryCode
			  ,CP.[PaymentToken]
			  ,SP.[PlanAmount]  
			  ,CP.CustomerPaymentID
			  ,IsFirstPaymentDue
		FROM tescosubscription.CustomerSubscription CS
			JOIN tescosubscription.Customerpayment CP		ON  CP.CustomerID	=	CS.CustomerID
															AND CP.PaymentModeID=1
															AND CP.IsActive = 1
															AND CS.PaymentProcessStatus = @SuccessPaymentProcessStatus
															AND CS.NextRenewalDate <= @EndOfDay 
                                                            AND CS.NextRenewalDate <  CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101)
															AND CS.SubscriptionStatus = @ActiveSubscriptionStatus
            JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
			                                                AND SP.PaymentInstallmentID = 1	
			JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID
           
                                                            
            

       UNION ALL
 
       --Below query is to process the monthly payment and renewal for monthly payment plans records only.
       SELECT TOP (@BatchSize) 
			   CS.[CustomerSubscriptionID]
			  ,CS.CustomerID
			  ,CCM.CountryCode
			  ,CP.[PaymentToken]
			  ,ROUND(SP.[PlanAmount]/SP.PlanTenure,2)  * InstallmentTenure PlanAmount
              ,CP.CustomerPaymentID
			  ,IsFirstPaymentDue
		FROM tescosubscription.CustomerSubscription CS
			JOIN tescosubscription.Customerpayment CP		ON  CP.CustomerID	=	CS.CustomerID
															AND CP.PaymentModeID=1
															AND CP.IsActive = 1
															AND CS.PaymentProcessStatus = @SuccessPaymentProcessStatus
															AND CS.NextPaymentDate <= @EndOfDay
                                                            AND CS.NextPaymentDate < CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101)
															AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus or CS.SubscriptionStatus = @PendingStopSubscriptionStatus)
			JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
			                                                 AND SP.PaymentInstallmentID <> 1
			JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID
            JOIN tescoSubscription.PaymentInstallment IP    ON SP.PaymentInstallmentID      =   IP.PaymentInstallmentID
                                                            

		--Insert INTO CustomerPaymentHistory table
		INSERT INTO [Tescosubscription].[CustomerPaymentHistory]
			   (CustomerPaymentID
				,CustomerSubscriptionID
				,PaymentDate
				,PaymentAmount
				,ChannelID
				,PackageExecutionHistoryID)
		SELECT
			CustomerPaymentID
			,CustomerSubscriptionID	
			,@CreatedDate
			,PlanAmount
			,@RecurringChannelID
			,@PackageExecutionHistoryID
		FROM @Subs  
	
		--Update the status as InProgress
			
		UPDATE	CS
			SET		CS.PaymentProcessStatus =	@InProgressPaymentProcessStatus  -- Update the status to be in progress
					,CS.UTCUpdatedDateTime	=	@CurrentUTCDate
		FROM @Subs Subs  
			INNER JOIN	tescosubscription.CustomerSubscription CS ON Subs.CustomerSubscriptionID = CS.CustomerSubscriptionID
	

	--The following details are sent to the Scheduler Service
		SELECT
			 CustomerPaymentHistoryID
			,[CustomerID]
			,[Region]
			,[PaymentToken]
			,[PlanAmount]
			-- For cards whose first payment is due, 'Web' is used as the Channel to accomodate RONo requirements.
			-- But in the CustomerPaymentHistory, 'Subscriptions' is recorded as the channel after the payment.
			,CASE	
					WHEN	IsFirstPaymentDue = 1	THEN @WebChannel
					ELSE	@RecurringChannel END AS 'Channel'
		FROM	@Subs Subs 
		JOIN [Tescosubscription].[CustomerPaymentHistory] CH
			ON CH.CustomerSubscriptionID=Subs.CustomerSubscriptionID
		WHERE 
			PackageExecutionHistoryID=@PackageExecutionHistoryID

	END

GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsDueRenewalGet1] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet1]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet1] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet1] not created.',16,1)
		END
	GO




IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet2]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsDueRenewalGet2]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet2] not dropped.',16,1)
			END
	END
GO


   CREATE PROCEDURE	[tescosubscription].[CustomerSubscriptionsDueRenewalGet2] 
	(
		--INPUT PARAMETERS HERE--
		@BatchSize INT
		,@PackageExecutionHistoryID BIGINT
	)
	AS
	/*  Author:			Robin
		Date created:	2 May 2014
		Purpose:		To fetch batches of Subscriptions to be renewed and initiate the payment transactions
		Behaviour:		Fetches a batch of renewal customers, initiates the payment and retrieves the data as needed by the web service to process the payment.
		Usage:			Often in batch
		Called by:		DataFlow task in RenewCustomerSubscriptions [SSIS Package]
	

		--Modifications History--
		Changed On		Changed By		Defect Ref		Change Description
        23-Apr-2014     Saritha Kommineni		       Added logic to fetch recors with InProgressPaymentProcessStatus		
		25-Jun-2014		Deepmala Trivedi				Reverted the logic for InProgressPaymentProcessStatus
	
	*/

	BEGIN
		SET NOCOUNT ON
		-- Declare a table variable to get the desired customer subscriptions

		DECLARE	@Subs		TABLE
		(
			 CustomerSubscriptionID	BIGINT UNIQUE
			,CustomerID				BIGINT
			,Region					CHAR(2)		
			,PaymentToken			NVARCHAR(44)
			,PlanAmount				SMALLMONEY
			,CustomerPaymentID		BIGINT
			,IsFirstPaymentDue      BIT
			,CurrentPlanId			INT
			,OldPlanId				INT
			,NewPlanId				INT
			,PackageExecutionHistoryID	BIGINT	
			,IsSwitchedToday			BIT		
		)       

		DECLARE @EndOfDay DATETIME
				,@CurrentUTCDate DATETIME	
				,@SuccessPaymentProcessStatus TINYINT 
				,@InProgressPaymentProcessStatus TINYINT
				,@ActiveSubscriptionStatus TINYINT
				,@PendingStopSubscriptionStatus TINYINT
				,@WebChannel VARCHAR(20)
				,@RecurringChannel VARCHAR(20)
				,@WebChannelID TINYINT
				,@RecurringChannelID	TINYINT
				,@CreatedDate Datetime
				,@RenewalInProgressAttempts  SMALLINT

	 
		SELECT
		        @EndOfDay = CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE(), 101) + ' 23:59:59') 	 -- Set today's date with time set to end of day.
			   ,@CurrentUTCDate = GETUTCDATE()	
			 -- Below Assigned values are status Id reference data from status master table
			   ,@SuccessPaymentProcessStatus = 6 	
			   ,@InProgressPaymentProcessStatus = 5
			   ,@ActiveSubscriptionStatus = 8
			   ,@PendingStopSubscriptionStatus = 11
			   ,@WebChannelID = 1	-- channel id for first time payment for a particular card through scheduler
			   ,@RecurringChannelID = 2	  -- channel id for recurring payment through scheduler
			   ,@CreatedDate = GETDATE()
               
               
		   
		SELECT @WebChannel = ChannelName FROM tescosubscription.ChannelMaster WITH (NOLOCK) WHERE ChannelID =  @WebChannelID
	
		SELECT @RecurringChannel = ChannelName FROM tescosubscription.ChannelMaster WITH (NOLOCK) WHERE ChannelID =  @RecurringChannelID
             
        SELECT @RenewalInProgressAttempts = SettingValue FROM [tescosubscription].[ConfigurationSettings] WHERE SettingName = 'RenewalInProgressAttempts'
		
		--	hard coded values are stored in variables for ease of future changes if any.
		--Below query is to get the upfront processing records only.
	
		INSERT INTO @Subs
		(
			CustomerSubscriptionID	
			,CustomerID			
			,Region								
			,PaymentToken	
			,PlanAmount	
			,CustomerPaymentID	
			,IsFirstPaymentDue	
			,CurrentPlanId
			,OldPlanId
			,NewPlanId
			,PackageExecutionHistoryID	
			,IsSwitchedToday		
		)
		SELECT TOP (@BatchSize) 
			CS.[CustomerSubscriptionID]
			,CS.CustomerID
			,CCM.CountryCode
			,CP.[PaymentToken]
			,SP.[PlanAmount]  
			,CP.CustomerPaymentID
			,IsFirstPaymentDue
			,CS.SubscriptionPlanId--In case of switch it would return the new plan
			,case when CS.SwitchCustomerSubscriptionId is not null 
				then Source_CS.SubscriptionPlanId--(Select SubscriptionPlanId from tescosubscription.CustomerSubscription where CustomerSubscriptionId = SwitchCustomerSubscriptionId)
				else 0 end as OldPlanId
			,IsNull(CS.SwitchTo, 0) as NewPlanId
			,@PackageExecutionHistoryID	
			,(case when convert(varchar,CS.CustomerPlanStartDate,112) = convert(varchar,getdate(),112) then 1 else 0 end) as IsSwitchedToday--For notification purpose (SwitchSuccess email)
		FROM tescosubscription.CustomerSubscription CS
			LEFT JOIN tescosubscription.CustomerSubscription Source_CS  ON  CS.SwitchCustomerSubscriptionID =Source_CS.CustomerSubscriptionID		
			JOIN tescosubscription.Customerpayment CP		ON  CP.CustomerID	=	CS.CustomerID
															AND CP.PaymentModeID=1
															AND CP.IsActive = 1															
														    AND CS.PaymentProcessStatus = @SuccessPaymentProcessStatus
															AND CS.NextRenewalDate <= @EndOfDay 
                                                            AND CS.NextRenewalDate <  CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101)
															AND CS.SubscriptionStatus = @ActiveSubscriptionStatus
            JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID =	SP.SubscriptionPlanID
			                                                AND SP.PaymentInstallmentID = 1	
			JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID = SP.CountryCurrencyID

       UNION ALL
 
       --Below query is to process the monthly payment and renewal for monthly payment plans records only.
       SELECT TOP (@BatchSize) 
			CS.[CustomerSubscriptionID]
			,CS.CustomerID
			,CCM.CountryCode
			,CP.[PaymentToken]
			,ROUND(SP.[PlanAmount],2) PlanAmount--ROUND(SP.[PlanAmount]/SP.PlanTenure,2)  * InstallmentTenure PlanAmount
			,CP.CustomerPaymentID
			,IsFirstPaymentDue
			,CS.SubscriptionPlanId--In case of switch it would return the new plan
			,case when CS.SwitchCustomerSubscriptionId is not null 
				then Source_CS.SubscriptionPlanId--(Select SubscriptionPlanId from tescosubscription.CustomerSubscription where CustomerSubscriptionId = SwitchCustomerSubscriptionId)
				else 0 end as OldPlanId
			,IsNull(CS.SwitchTo, 0) as NewPlanId
			,@PackageExecutionHistoryID			
			,(case when convert(varchar,CS.CustomerPlanStartDate,112) = convert(varchar,getdate(),112) then 1 else 0 end) as IsSwitchedToday --For notification purpose (SwitchSuccess email)
		FROM tescosubscription.CustomerSubscription CS
			LEFT JOIN tescosubscription.CustomerSubscription Source_CS  ON  CS.SwitchCustomerSubscriptionID =Source_CS.CustomerSubscriptionID		
			JOIN tescosubscription.Customerpayment CP		ON  CP.CustomerID	=	CS.CustomerID
															AND CP.PaymentModeID=1
															AND CP.IsActive = 1
															AND CS.PaymentProcessStatus = @SuccessPaymentProcessStatus															
															AND CS.NextPaymentDate <= @EndOfDay
                                                            AND CS.NextPaymentDate < CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101)
															AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus or CS.SubscriptionStatus = @PendingStopSubscriptionStatus)
			JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID =	SP.SubscriptionPlanID
			                                                 AND SP.PaymentInstallmentID <> 1
			JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID =	SP.CountryCurrencyID
            JOIN tescoSubscription.PaymentInstallment IP    ON SP.PaymentInstallmentID = IP.PaymentInstallmentID                                                            


			
		UPDATE	CS
			SET		CS.PaymentProcessStatus =	@InProgressPaymentProcessStatus  -- Update the status to be in progress
					,CS.UTCUpdatedDateTime	=	@CurrentUTCDate
		FROM @Subs Subs  
			INNER JOIN	tescosubscription.CustomerSubscription CS ON Subs.CustomerSubscriptionID = CS.CustomerSubscriptionID
	

	--The following details are sent to the Scheduler Service	
		SELECT
			-- CustomerPaymentHistoryID
			[CustomerID]
			,[Region]
			,[PaymentToken]
			,[PlanAmount]
			-- For cards whose first payment is due, 'Web' is used as the Channel to accomodate RONo requirements.
			-- But in the CustomerPaymentHistory, 'Subscriptions' is recorded as the channel after the payment.
			,CASE	
					WHEN	IsFirstPaymentDue = 1	THEN @WebChannel
					ELSE	@RecurringChannel END AS 'Channel'
			,CurrentPlanId
			,OldPlanId
			,NewPlanId
			,PackageExecutionHistoryID
			,CustomerPaymentId
			,CustomerSubscriptionId
			,IsSwitchedToday
		FROM	@Subs Subs 
	
	END
GO
	
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsDueRenewalGet2] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsDueRenewalGet2]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet2] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsDueRenewalGet2] not created.',16,1)
	END
GO









IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsGet] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet] not dropped.',16,1)
				
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionsGet]
(
	@CustomerID BIGINT,
	@Top TINYINT =3
)
AS

/*

	Author:			Saminathan
	Date created:	03/08/2011
	Purpose:		Returns Customer subscription Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>
	--exec [tescosubscription].[CustomerSubscriptionsGet] 111,''

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    04 Aug 2011		saritha							SP name changed from  GetCustomerSubscriptions to CustomerSubscriptionsGet
	19 Aug 2011		Joji							Added the NextRenewalDate in select list
    20 Sep 2011    Sam M						    Added condition to filter inactive status subscription
	12 Mar 2013    Robin                            Added CS.SwitchCustomerSubscriptionID SwitchCustomerSubscriptionID			
*/

	BEGIN
	
	  SET NOCOUNT ON
		SELECT  TOP (@Top)
			CS.CustomerSubscriptionID  CustomerSubscriptionID,
			CS.SubscriptionPlanID	   PlanSubscriptionID,
			CS.SwitchTo				   SwitchTo,
			SP.PlanName				   PlanName,
			CS.CustomerPlanStartDate   SubscriptionStartDate,
			CS.CustomerPlanEndDate     SubscriptionEndDate,
			--CS.SubscriptionStatus,
			SM.StatusName              Status,
			SP.PlanName				   PlaneName,
			SP.PlanTenure			   PlanTenure,
			SP.PlanAmount			   PlanAmount,
			CS.NextRenewalDate		   NextRenewalDate,
			CS.SwitchCustomerSubscriptionID SwitchCustomerSubscriptionID						
		FROM tescosubscription.CustomerSubscription CS 
		INNER JOIN tescosubscription.SubscriptionPlan SP  ON  CS.CustomerID = @CustomerID and CS.SubscriptionStatus <> 15 AND CS.SubscriptionPlanID = SP.SubscriptionPlanID
		INNER JOIN tescosubscription.StatusMaster  SM  ON CS.SubscriptionStatus=SM.StatusId
		ORDER BY  CS.UTCUpdatedDateTime desc
	END
	
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet] not created.',16,1)
		
	END
GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsGet1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet1] not dropped.',16,1)
			END
	END 
GO


CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionsGet1]
(
	@CustomerID BIGINT,
	@Top TINYINT =3
)
AS

/*

	Author:			Robin
	Date created:	22/05/2013
	Purpose:		Returns Customer subscription Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>/<DS>
	--exec [tescosubscription].[CustomerSubscriptionsGet1] 72723194,100

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
   30 May 2013      Robin                           Added Case logic to NextPaymentDate 	
*/

	BEGIN
	
	  SET NOCOUNT ON
		SELECT  TOP (@Top)
			CS.CustomerSubscriptionID  CustomerSubscriptionID,
			CS.SubscriptionPlanID	   PlanSubscriptionID,
			CS.SwitchTo				   SwitchTo,
			SP.PlanName				   PlanName,
			CS.CustomerPlanStartDate   SubscriptionStartDate,
			CS.CustomerPlanEndDate     SubscriptionEndDate,
			SM.StatusName              Status,
			SP.PlanName				   PlaneName,
			SP.PlanTenure			   PlanTenure,
			SP.PlanAmount			   PlanAmount,
			CS.NextRenewalDate		   NextRenewalDate,
			CS.SwitchCustomerSubscriptionID SwitchCustomerSubscriptionID,	
            ISNULL(CS.NextPaymentDate, CS.NextRenewalDate) NextPaymentDate,
	        CASE WHEN CS.NextPaymentDate IS NULL THEN 0 ELSE ISNULL(DATEDIFF(M,CS.NextPaymentDate,CS.NextRenewalDate)/IP.InstallmentTenure,0) END RemainingInstallments					
		FROM tescosubscription.CustomerSubscription CS (NOLOCK)
		INNER JOIN tescosubscription.SubscriptionPlan SP (NOLOCK)  ON CS.SubscriptionPlanID = SP.SubscriptionPlanID
		INNER JOIN tescosubscription.StatusMaster  SM (NOLOCK) ON CS.SubscriptionStatus=SM.StatusId
        INNER JOIN tescosubscription.PaymentInstallment IP (NOLOCK) ON Sp.PaymentInstallmentID = IP.PaymentInstallmentID 
        WHERE CS.CustomerID = @CustomerID
        AND CS.SubscriptionStatus <> 15
		ORDER BY  CS.UTCUpdatedDateTime desc
	END
	

GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsGet1] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet1]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet1] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet1] not created.',16,1)
		END
	GO




USE [TescoSubscription]
GO
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet2]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsGet2]
    
    IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet2]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet2] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet2] not dropped.',
            16,
            1
        )
    END
END

GO
CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionsGet2]
(
	@CustomerID BIGINT,
	@Top TINYINT =5
)
AS

/*

	Author:			Robin
	Date created:	22/05/2013
	Purpose:		Returns Customer subscription Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>/<DS>
	--exec [tescosubscription].[CustomerSubscriptionsGet1] 72723194,100

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
   30 May 2013      Robin                           Added Case logic to NextPaymentDate
   07 May 2014		HarshaByloor					Versioned to return 5 rows 	
*/

	BEGIN
	
	  SET NOCOUNT ON
		SELECT  TOP (@Top)
			CS.CustomerSubscriptionID  CustomerSubscriptionID,
			CS.SubscriptionPlanID	   PlanSubscriptionID,
			CS.SwitchTo				   SwitchTo,
			SP.PlanName				   PlanName,
			CS.CustomerPlanStartDate   SubscriptionStartDate,
			CS.CustomerPlanEndDate     SubscriptionEndDate,
			SM.StatusName              Status,
			SP.PlanName				   PlaneName,
			SP.PlanTenure			   PlanTenure,
			SP.PlanAmount			   PlanAmount,
			CS.NextRenewalDate		   NextRenewalDate,
			CS.SwitchCustomerSubscriptionID SwitchCustomerSubscriptionID,	
            ISNULL(CS.NextPaymentDate, CS.NextRenewalDate) NextPaymentDate,
	        CASE WHEN CS.NextPaymentDate IS NULL THEN 0 ELSE ISNULL(DATEDIFF(M,CS.NextPaymentDate,CS.NextRenewalDate)/IP.InstallmentTenure,0) END RemainingInstallments					
		FROM tescosubscription.CustomerSubscription CS WITH (NOLOCK)
		INNER JOIN tescosubscription.SubscriptionPlan SP WITH (NOLOCK)  
        ON CS.SubscriptionPlanID = SP.SubscriptionPlanID
		INNER JOIN tescosubscription.StatusMaster  SM WITH (NOLOCK) 
        ON CS.SubscriptionStatus=SM.StatusId
        INNER JOIN tescosubscription.PaymentInstallment IP WITH (NOLOCK) 
        ON SP.PaymentInstallmentID = IP.PaymentInstallmentID 
        WHERE CS.CustomerID = @CustomerID
        AND CS.SubscriptionStatus <> 15
		ORDER BY  CS.UTCUpdatedDateTime DESC
	END
	
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsGet2] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet2]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet2] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet2] not created.',
        16,
        1
    )
END
GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsSwitchDueRenewal]',N'P') IS NOT NULL
		BEGIN

			DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal]

			IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsSwitchDueRenewal]',N'P') IS NULL
				BEGIN
					PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal] dropped.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal] not dropped.',16,1)
				END
		END
	GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal]

AS

/*

	Author:			Robin
	Date created:	15 Jan 2013
	Purpose:		CustomerSubscriptionsSwitchDueRenewal 
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		DS
	--exec [tescosubscription].[CustomerSubscriptionsGet] 111,''

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    15 Jan 2013     Robin                           New SP 
	17 Jan 2013     Robin                           Added CustomerPlanEndDate = @CurrentUTCDate
*/

BEGIN

		SET NOCOUNT ON

		DECLARE @CurrentUTCDate	DATETIME,
				@CurrentDate	DATETIME,
				@SubscriptionActiveStatus TinyInt,
				@SubscriptionPendingStoppedStatus TinyInt,
				@SubscriptionSwitchedStatus TinyInt,
				@errorDescription NVARCHAR(2048),
				@error INT,
				@errorProcedure	SYSNAME,
				@errorLine	INT,
                @SwitchSucess TinyInt -- For Switch Sucess Status in Switch History Table  
                 

		SELECT	@CurrentUTCDate = GETUTCDATE(),	@CurrentDate = GETDATE()
				,@SubscriptionActiveStatus = 8,
				@SubscriptionPendingStoppedStatus = 11,
				@SubscriptionSwitchedStatus = 16,
                @SwitchSucess = 19 --Switch History Table 


		CREATE TABLE #PlanSwitchSubscriptions
		(
			CustomerSubscriptionID BIGINT,
			NewCustomerSubscriptionID BIGINT,
			SwitchTo TinyInt
		)


		 BEGIN TRY


		BEGIN TRAN

				INSERT INTO [TescoSubscription].[CustomerSubscription]
					   (
							[CustomerID]
						   ,[SubscriptionPlanID]
						   ,[CustomerPlanStartDate]
						   ,[CustomerPlanEndDate]
						   ,[NextRenewalDate]
						   ,[SubscriptionStatus]
						   ,[RenewalReferenceDate]
						   ,[SwitchCustomerSubscriptionID]
						)
			   OUTPUT inserted.SwitchCustomerSubscriptionID, inserted.CustomerSubscriptionID, inserted.SubscriptionPlanID INTO #PlanSwitchSubscriptions
				SELECT 
					PS.CustomerID,
					SwitchTo,
					@CurrentDate,
					'9999/12/31 23:59:59',
					@CurrentDate,
					@SubscriptionActiveStatus ,
					@CurrentDate,
					CustomerSubscriptionID
				FROM TescoSubscription.CustomerSubscription (NOLOCK) PS
				WHERE PS.NextRenewalDate <= CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE(), 101) + ' 23:59:59') 
				AND SubscriptionStatus IN (@SubscriptionActiveStatus,@SubscriptionPendingStoppedStatus) 
				AND SwitchTo IS NOT NULL
 

				UPDATE CS
				SET SubscriptionStatus = @SubscriptionSwitchedStatus,UTCUpdatedDateTime = @CurrentUTCDate, CustomerPlanEndDate = @CurrentUTCDate
				FROM TescoSubscription.customerSubscription CS 
				INNER JOIN #PlanSwitchSubscriptions PS on CS.CustomerSubscriptionID = PS.CustomerSubscriptionID

		COMMIT

				INSERT INTO [tescosubscription].[CustomerSubscriptionHistory]
					   ([CustomerSubscriptionID]
					   ,[SubscriptionStatus]
					   ,[Remarks])
				 SELECT
					   CustomerSubscriptionID
					   ,@SubscriptionSwitchedStatus
					   ,'Plan Switched'
				 FROM #PlanSwitchSubscriptions

				INSERT INTO [tescosubscription].[CustomerSubscriptionHistory]
					   ([CustomerSubscriptionID]
					   ,[SubscriptionStatus]
					   ,[Remarks])
				 SELECT
					   NewCustomerSubscriptionID
					   ,@SubscriptionActiveStatus
					   ,'Created New subs'
				 FROM #PlanSwitchSubscriptions

		INSERT INTO [TescoSubscription].[tescosubscription].[CustomerSubscriptionSwitchHistory]
				   ([CustomerSubscriptionID]
				   ,[SwitchTo]
				   ,[SwitchStatus]
                   ,[SwitchOrigin])
		SELECT CustomerSubscriptionID
					   ,SwitchTo
					   ,@SwitchSucess
                       ,'Scheduler'
				 FROM #PlanSwitchSubscriptions
   
		END TRY
			BEGIN CATCH

			  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
						  , @error                = ERROR_NUMBER()
						  , @errorDescription     = ERROR_MESSAGE()
						  , @errorLine            = ERROR_LINE()
			  FROM  INFORMATION_SCHEMA.ROUTINES
			  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

			 IF @@TRANCOUNT >0 ROLLBACK TRANSACTION 
     
			 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
       
			END CATCH

			DROP TABLE #PlanSwitchSubscriptions

		END


GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsSwitchDueRenewal]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal] not created.',16,1)
		END
	GO





IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1]

AS

/*

	Author:			Robin
	Date created:	15 Jan 2013
	Purpose:		CustomerSubscriptionsSwitchDueRenewal 
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		DS
	--exec [tescosubscription].[CustomerSubscriptionsGet] 111,''

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    15 Jan 2013     Robin                           New SP 
	17 Jan 2013     Robin                           Added CustomerPlanEndDate = @CurrentUTCDate added Go before granting permission
*/

BEGIN

		SET NOCOUNT ON

		DECLARE @CurrentUTCDate	DATETIME,
				@CurrentDate	DATETIME,
				@SubscriptionActiveStatus TinyInt,
				@SubscriptionPendingStoppedStatus TinyInt,
				@SubscriptionSwitchedStatus TinyInt,
				@errorDescription NVARCHAR(2048),
				@error INT,
				@errorProcedure	SYSNAME,
				@errorLine	INT,
                @SwitchSucess TinyInt -- For Switch Sucess Status in Switch History Table  
                 

		SELECT	@CurrentUTCDate = GETUTCDATE(),	@CurrentDate = GETDATE()
				,@SubscriptionActiveStatus = 8,
				@SubscriptionPendingStoppedStatus = 11,
				@SubscriptionSwitchedStatus = 16,
                @SwitchSucess = 19 --Switch History Table 


		CREATE TABLE #PlanSwitchSubscriptions
		(
			CustomerSubscriptionID BIGINT,
			NewCustomerSubscriptionID BIGINT,
			SwitchTo TinyInt
		)


		 BEGIN TRY


		BEGIN TRAN

				INSERT INTO [TescoSubscription].[CustomerSubscription]
					   (
							[CustomerID]
						   ,[SubscriptionPlanID]
						   ,[CustomerPlanStartDate]
						   ,[CustomerPlanEndDate]
						   ,[NextRenewalDate]
						   ,[SubscriptionStatus]
						   ,[RenewalReferenceDate]
						   ,[SwitchCustomerSubscriptionID]
							,[NextPaymentDate]
						)
			   OUTPUT inserted.SwitchCustomerSubscriptionID, inserted.CustomerSubscriptionID, inserted.SubscriptionPlanID INTO #PlanSwitchSubscriptions
				SELECT 
					PS.CustomerID,
					SwitchTo,
					@CurrentDate,
					'9999/12/31 23:59:59',
					@CurrentDate,
					@SubscriptionActiveStatus ,
					@CurrentDate,
					CustomerSubscriptionID,
					(Case When SP.PaymentInstallmentId != 1 Then getdate() Else null End)
				FROM TescoSubscription.CustomerSubscription (NOLOCK) PS
				INNER JOIN TescoSubscription.SubscriptionPlan (NOLOCK) SP on SP.SubscriptionPlanId = PS.SwitchTo 
				WHERE PS.NextRenewalDate <= CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE(), 101) + ' 23:59:59') 
				AND SubscriptionStatus IN (@SubscriptionActiveStatus,@SubscriptionPendingStoppedStatus) 
				AND SwitchTo IS NOT NULL
 

				UPDATE CS
				SET SubscriptionStatus = @SubscriptionSwitchedStatus,
				UTCUpdatedDateTime = @CurrentUTCDate, CustomerPlanEndDate = @CurrentUTCDate
				FROM TescoSubscription.customerSubscription CS 
				INNER JOIN #PlanSwitchSubscriptions PS on CS.CustomerSubscriptionID = PS.CustomerSubscriptionID

		COMMIT

				INSERT INTO [tescosubscription].[CustomerSubscriptionHistory]
					   ([CustomerSubscriptionID]
					   ,[SubscriptionStatus]
					   ,[Remarks])
				 SELECT
					   CustomerSubscriptionID
					   ,@SubscriptionSwitchedStatus
					   ,'Plan Switched'
				 FROM #PlanSwitchSubscriptions

				INSERT INTO [tescosubscription].[CustomerSubscriptionHistory]
					   ([CustomerSubscriptionID]
					   ,[SubscriptionStatus]
					   ,[Remarks])
				 SELECT
					   NewCustomerSubscriptionID
					   ,@SubscriptionActiveStatus
					   ,'Created New subs'
				 FROM #PlanSwitchSubscriptions

		INSERT INTO [TescoSubscription].[tescosubscription].[CustomerSubscriptionSwitchHistory]
				   ([CustomerSubscriptionID]
				   ,[SwitchTo]
				   ,[SwitchStatus]
                   ,[SwitchOrigin])
		SELECT CustomerSubscriptionID
					   ,SwitchTo
					   ,@SwitchSucess
                       ,'Scheduler'
				 FROM #PlanSwitchSubscriptions
   
		END TRY
			BEGIN CATCH

			  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
						  , @error                = ERROR_NUMBER()
						  , @errorDescription     = ERROR_MESSAGE()
						  , @errorLine            = ERROR_LINE()
			  FROM  INFORMATION_SCHEMA.ROUTINES
			  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

			 IF @@TRANCOUNT >0 ROLLBACK TRANSACTION 
     
			 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
       
			END CATCH

			DROP TABLE #PlanSwitchSubscriptions

		END

GO
	
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsSwitchDueRenewal1] not created.',16,1)
	END
GO



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
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionSwitchGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionSwitchGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionSwitchGet] not dropped.',16,1)
			END
	END 
GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionSwitchGet] 
(
      @CustomerSubscriptionID  BIGINT
     ,@CustomerID  BIGINT
)

AS
/*
Author:			Robin
Date created:	18 Feb 2013
Purpose:		To get the Switch history Details Based on CustomerSubscriptionID
Behaviour:		
Usage:			
Called by:		<DS>/Juvo

Execute [tescosubscription].[CustomerSubscriptionSwitchGet]  560603,72723281
select * from [tescosubscription].[CustomerSubscriptionSwitchHistory]where customersubscriptionid = 475993
insert into  [tescosubscription].[CustomerSubscriptionSwitchHistory] values (475993,1,16,'Scheduler',getdate())
 where customerSubscriptionID = 475993

--Modifications History--
	Changed On		Changed By		Defect Ref		                                Change Description
	
	
*/
BEGIN
	   
	SET NOCOUNT ON

IF EXISTS(SELECT 1 FROM tescosubscription.CustomerSubscription WHERE CustomerSubscriptionID = @CustomerSubscriptionID 
                                                                     AND CustomerID = @CustomerID )

BEGIN

     SELECT  SH.UTCRequestedDateTime DateRequested
		    ,Target_SP.PlanName NameOfNewPlan
		    ,Target_SM.StatusName Status 
		    ,Target_SP.PlanAmount PlanAmount 
            ,Target_SP.BasketValue MinimumOrder 
            ,Target_SP.PlanTenure PeriodOfPlan
			,CASE WHEN SH.SwitchStatus = 18 THEN NULL ELSE CS.NextRenewalDate END StartDate            
            ,SH.SwitchStatus
	 FROM tescosubscription.CustomerSubscription CS (NOLOCK)
	 INNER JOIN tescosubscription.SubscriptionPlan SP (NOLOCK)
	 ON CS.SubscriptionPlanID = SP.SubscriptionPlanID
	 INNER JOIN tescosubscription.StatusMaster SM (NOLOCK)
	 ON CS.SubscriptionStatus = SM.StatusID
     INNER JOIN tescosubscription.CustomerSubscriptionSwitchHistory SH (NOLOCK)
     ON CS.CustomerSubscriptionID = SH.CustomerSubscriptionID
     LEFT OUTER JOIN tescosubscription.SubscriptionPlan Target_SP (NOLOCK)
     ON SH.SwitchTo = Target_SP.SubscriptionPlanID
     INNER JOIN tescosubscription.StatusMaster Target_SM (NOLOCK)
     ON SH.SwitchStatus = Target_SM.StatusID
	 WHERE SH.CustomerSubscriptionID = @CustomerSubscriptionID 
     ORDER BY DateRequested DESC

END

ELSE
 
RAISERROR('[Procedure:INVALID INPUT ]',16,1)

END


GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionSwitchGet] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchGet]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionSwitchGet] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionSwitchGet] not created.',16,1)
		END
	GO










	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistoryGet]',N'P') IS NOT NULL
		BEGIN

			DROP PROCEDURE [tescosubscription].[CustomerSubscriptionSwitchHistoryGet]

			IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistoryGet]',N'P') IS NULL
				BEGIN
					PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionSwitchHistoryGet] dropped.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionSwitchHistoryGet] not dropped.',16,1)
				END
		END
	GO



CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionSwitchHistoryGet] 
(
     @CustomerID BIGINT 
    ,@PageStart SMAllINT
    ,@TotalRecords   SMALLINT
)

AS
/*
Author:			Robin
Date created:	18 Feb 2013
Purpose:		To get the Switch history Details Based on CustomerID
Behaviour:		
Usage:			
Called by:		<DS>/Juvo

Execute [tescosubscription].[CustomerSubscriptionSwitchHistoryGet] 72723281,1,200
 

--Modifications History--
	Changed On		Changed By		Defect Ref		                                Change Description
	07 Mar 2013     Robin                                                           Changed the status Id as per the new status introduced 
	13 Mar 2013     Robin                                                           Changed the nextrenewaldate logic
*/
BEGIN
	   
	SET NOCOUNT ON

 
;WITH CTE
AS           --Inserting Records into Temp Table
(
	 SELECT  --CS.CustomerSubscriptionID
             SP.PlanName ExistingPlanName
			--,SM.StatusName ExistingStatusName
			,CS.NextRenewalDate SwitchDate
			,SH.UTCRequestedDateTime DateRequested
		    ,Target_SP.PlanName
		    ,Target_SM.StatusName
		    ,Target_SP.PlanAmount 
			,ROW_NUMBER() OVER(ORDER BY SH.UTCRequestedDateTime DESC) AS RowNum
			,SH.SwitchStatus
	 FROM tescosubscription.CustomerSubscription CS (NOLOCK)
	 INNER JOIN tescosubscription.SubscriptionPlan SP (NOLOCK)
	 ON CS.SubscriptionPlanID = SP.SubscriptionPlanID
	 INNER JOIN tescosubscription.StatusMaster SM (NOLOCK)
	 ON CS.SubscriptionStatus = SM.StatusID
     INNER JOIN tescosubscription.CustomerSubscriptionSwitchHistory SH (NOLOCK)
     ON CS.CustomerSubscriptionID = SH.CustomerSubscriptionID
     LEFT OUTER JOIN tescosubscription.SubscriptionPlan Target_SP (NOLOCK)
     ON SH.SwitchTo = Target_SP.SubscriptionPlanID
     INNER JOIN tescosubscription.StatusMaster Target_SM (NOLOCK)
     ON SH.SwitchStatus = Target_SM.StatusID
	 WHERE CS.CustomerID = @CustomerID
)


SELECT  DateRequested                   -- Select the records from Temp Table along with Row_Number()
       ,ExistingPlanName 'From'
       ,PlanName 'To'
       ,StatusName 'Status'
       ,PlanAmount
	   ,CASE WHEN SwitchStatus = 18 THEN NULL ELSE SwitchDate END SwitchDate 
       FROM CTE
       WHERE RowNum BETWEEN @PageStart and (@PageStart + @TotalRecords - 1)
       ORDER BY RowNum


SELECT  COUNT(*) TotalRecords
	 FROM tescosubscription.CustomerSubscription CS (NOLOCK)
	 INNER JOIN tescosubscription.CustomerSubscriptionSwitchHistory SH (NOLOCK)
     ON CS.CustomerSubscriptionID = SH.CustomerSubscriptionID
     WHERE CS.CustomerID = @CustomerID


            
END


	GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionSwitchHistoryGet] TO [SubsUser]
	GO

	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistoryGet]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionSwitchHistoryGet] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionSwitchHistoryGet] not created.',16,1)
		END
	GO









IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionSwitchSave]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionSwitchSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionSwitchSave] not dropped.',16,1)
			END
	END 
GO


CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionSwitchSave] 
(
  --INPUT PARAMETERS HERE--
     @CustomerID BIGINT
	,@SubscriptionID BIGINT
    ,@SwitchTo INT
	,@SwitchOrigin  VARCHAR(60)
    
)
AS
/*  Author:			Robin John
	Date created:	22 Jan 2013
	Purpose:		To update Customersubscription and insert records in Customersubscriptionswitchhistorytable 
	Behaviour:		Creates entry in CustomersubscriptionSwitchHistory table and CustomerSubscription table.
	Usage:			Whenever a customer Switches a plan on the website there is a entry made in CustomersubscriptionSwitchHistory table and CustomerSubscription 
	Called by:		DS and Juvo
	WarmUP Script:  EXECUTE [tescosubscription].[CustomerSubscriptionSwitchSave] 500,0,0 
--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	21 Jan 2013     Robin                           New Sp	
	07 Mar 2013     Robin                           Modified as per the new switch status introduced
	23 Mar 2013     Robin                           Added switch origin as the input variable 						
*/
 
 

BEGIN	
	SET NOCOUNT ON
    DECLARE 
    @SwitchStatusCancel TINYINT
	,@SwitchStatusInitiated TINYINT
	,@SwitchToExisting INT
	,@errorDescription	NVARCHAR(2048)
	,@error				INT
	,@errorProcedure	SYSNAME
	,@errorLine			INT


		SELECT @SwitchStatusInitiated = 17 , @SwitchStatusCancel = 18, @SwitchToExisting=SwitchTo  
		FROM [Tescosubscription].[CustomerSubscription] (NOLOCK) -- GET SwitchTo Record Before Update
		WHERE CustomerSubscriptionID = @SubscriptionID AND CustomerID = @Customerid 
         
	   IF @SwitchStatusInitiated IS NULL OR (@SwitchToExisting IS NULL AND @SwitchTo IS NULL  ) OR (@SwitchToExisting = @SwitchTo)
	   BEGIN
		    RAISERROR('[Procedure:INVALID INPUT ]',16,1)
			return (-1) 
	   END
	 
	BEGIN TRY
		BEGIN TRAN

    	UPDATE [TescoSubscription].[CustomerSubscription] -- Update the SwitchTo Coloumn 
		SET SwitchTo = @SwitchTo, UTCUpdatedDateTime = GETUTCDATE()  -- Update the SwitchTo coloumn and UTCUpdatedDateTime
		WHERE CustomerSubscriptionID = @SubscriptionID 
     

		INSERT INTO [tescosubscription].[CustomerSubscriptionSwitchHistory]
			   (
				    [CustomerSubscriptionID]
                   ,[SwitchTo]
                   ,[SwitchStatus]
				   ,[SwitchOrigin]
				   
				)
		SELECT @SubscriptionID
			,ISNULL(@SwitchTO,@SwitchToExisting)
			,CASE WHEN @SwitchTO IS NULL THEN @SwitchStatusCancel ELSE @SwitchStatusInitiated END
			,@SwitchOrigin
		
      COMMIT TRANSACTION

	END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		ROLLBACK TRANSACTION 
     

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
       
	END CATCH

END


GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionSwitchSave] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchSave]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionSwitchSave] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionSwitchSave] not created.',16,1)
		END
	GO





USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchSave1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionSwitchSave1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchSave1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionSwitchSave1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionSwitchSave1] not dropped.',16,1)
			END
	END
GO
CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionSwitchSave1] 
(
  --INPUT PARAMETERS HERE--
     @CustomerID BIGINT
	,@SubscriptionID BIGINT
    ,@SwitchTo INT
	,@SwitchOrigin  VARCHAR(60)
    
)
AS
/*  Author:			Robin John
	Date created:	22 April 2013
	Purpose:		To update Customersubscription and insert records in Customersubscriptionswitchhistorytable 
	Behaviour:		Creates entry in CustomersubscriptionSwitchHistory table and CustomerSubscription table.
	Usage:			Whenever a customer Switches a plan on the website there is a entry made in CustomersubscriptionSwitchHistory table and CustomerSubscription 
	Called by:		DS and Juvo
	WarmUP Script:  EXECUTE [tescosubscription].[CustomerSubscriptionSwitchSave] 500,0,0 
--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	21 April 2013   Robin                           New Versioned SP (Added check to cancel the existing switch , when customer is switching to different plan)			
*/
 
 

BEGIN	
	SET NOCOUNT ON
    DECLARE 
    @SwitchStatusCancel TINYINT
	,@SwitchStatusInitiated TINYINT
	,@SwitchToExisting INT
	,@errorDescription	NVARCHAR(2048)
	,@error				INT
	,@errorProcedure	SYSNAME
	,@errorLine			INT


		SELECT @SwitchStatusInitiated = 17 , @SwitchStatusCancel = 18, @SwitchToExisting=SwitchTo  
		FROM [Tescosubscription].[CustomerSubscription] (NOLOCK) -- GET SwitchTo Record Before Update
		WHERE CustomerSubscriptionID = @SubscriptionID AND CustomerID = @Customerid 
    
	   IF @SwitchStatusInitiated IS NULL OR (@SwitchToExisting IS NULL AND @SwitchTo IS NULL  ) OR (@SwitchToExisting = @SwitchTo)
	   BEGIN

		    RAISERROR('[Procedure:INVALID INPUT ]',16,1)
		
			return (-1) 
	   END
	 
	BEGIN TRY
		BEGIN TRAN


    	UPDATE [TescoSubscription].[CustomerSubscription] -- Update the SwitchTo Coloumn 
		SET SwitchTo = @SwitchTo, UTCUpdatedDateTime = GETUTCDATE()  -- Update the SwitchTo coloumn and UTCUpdatedDateTime
		WHERE CustomerSubscriptionID = @SubscriptionID 


		IF (@SwitchToExisting IS NOT NULL AND @SwitchTo IS NOT NULL AND @SwitchToExisting <> @SwitchTo)
		   BEGIN
			INSERT INTO [tescosubscription].[CustomerSubscriptionSwitchHistory]
				   (
						[CustomerSubscriptionID]
					   ,[SwitchTo]
					   ,[SwitchStatus]
					   ,[SwitchOrigin]
					   
					)
			SELECT @SubscriptionID
				,@SwitchToExisting
				,@SwitchStatusCancel
				,@SwitchOrigin

	   END


		INSERT INTO [tescosubscription].[CustomerSubscriptionSwitchHistory]
			   (
				    [CustomerSubscriptionID]
                   ,[SwitchTo]
                   ,[SwitchStatus]
				   ,[SwitchOrigin]
				   
				)
		SELECT @SubscriptionID
			,ISNULL(@SwitchTO,@SwitchToExisting)
			,CASE WHEN @SwitchTO IS NULL THEN @SwitchStatusCancel ELSE @SwitchStatusInitiated END
			,@SwitchOrigin
		
      COMMIT TRANSACTION

	END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		ROLLBACK TRANSACTION 
     

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
       
	END CATCH

END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionSwitchSave1] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchSave1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionSwitchSave1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionSwitchSave1] not created.',16,1)
	END
GO







IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionUpdate] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionUpdate]
(
@CustomerSubscriptionID bigint,
@SubscriptionPlanID		int,
@CustomerPlanStartDate  datetime, 
@CustomerPlanEndDate    datetime,
@NextRenewalDate        datetime,
@RenewalReferenceDate   datetime,
@SubscriptionStatus     tinyint,
@PaymentProcessStatus   tinyint,
@Remarks                varchar(400)
)
AS

/*

	Author:			Saminathan
	Date created:	18/08/2011
	Purpose:		Updates Customer subscription Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>
	--exec [tescosubscription].[CustomerSubscriptionUpdate] 2018,69, null,null,null,null,9,6,'Test remarks-sami for stop'

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    26 Aug 2011		Saminathan						Modified Subs status from Stoppped to Pending Stop
    13 Sep 2011		Saritha K						Modified IF ..ELSE condition
	06 Dec 2012     Robin							Added UTC Date
*/
BEGIN

     DECLARE @errorDescription	NVARCHAR(2048)
			,@error				INT
			,@errorProcedure    SYSNAME
			,@errorLine	        INT
 			,@SwitchToExisting INT
			,@SwitchStatusCancel TINYINT
			,@SwitchOrigin VARCHAR(60)
	
	
	BEGIN TRY
	BEGIN TRANSACTION CustomerSubscriptionUpdate
	
       --Updates History when status change
    IF(@SubscriptionStatus is not null)
  BEGIN	
	INSERT INTO tescosubscription.CustomerSubscriptionHistory
					(
					CustomerSubscriptionID,
					SubscriptionStatus,
					Remarks					
					)
		VALUES
					(
					@CustomerSubscriptionID,
					@SubscriptionStatus,
					@Remarks
					)

IF(@SubscriptionStatus=9 OR @SubscriptionStatus=11) --When subsription status is cancel update enddate with current date  
  BEGIN  
   SELECT @CustomerPlanEndDate=
	CASE WHEN @SubscriptionStatus=9 THEN 
		getdate() 
	ELSE
		NextRenewalDate
	END,
	@SwitchStatusCancel = 18, @SwitchToExisting=SwitchTo , @SwitchOrigin='Juvo'
	FROM  tescosubscription.CustomerSubscription WHERE CustomerSubscriptionID=@CustomerSubscriptionID 

	IF @SwitchToExisting IS NOT NULL
	BEGIN
	INSERT INTO [tescosubscription].[CustomerSubscriptionSwitchHistory]
			   (
				    [CustomerSubscriptionID]
                   ,[SwitchTo]
                   ,[SwitchStatus]
				   ,[SwitchOrigin]
				   
				)
		SELECT @CustomerSubscriptionID
			,@SwitchToExisting
			,@SwitchStatusCancel
			,@SwitchOrigin
		END

  END  
   
  ELSE IF(@SubscriptionStatus=8) --When subcription status is active update Renewal reference date with current date. This will be used to calculate next renewal date  
  BEGIN  
   SELECT @RenewalReferenceDate=getdate()  
  END
    
 END 


UPDATE tescosubscription.CustomerSubscription 
	SET SubscriptionPlanID=COALESCE(@SubscriptionPlanID,SubscriptionPlanID),
		CustomerPlanStartDate=COALESCE(@CustomerPlanStartDate,CustomerPlanStartDate),
		CustomerPlanEndDate=COALESCE(@CustomerPlanEndDate,CustomerPlanEndDate),
		NextRenewalDate=COALESCE(@NextRenewalDate,NextRenewalDate),
		SubscriptionStatus=COALESCE(@SubscriptionStatus,SubscriptionStatus),
		PaymentProcessStatus=COALESCE(@PaymentProcessStatus,PaymentProcessStatus),
		RenewalReferenceDate=COALESCE(@RenewalReferenceDate,RenewalReferenceDate),  
		UTCUpdatedDateTime=GETUTCDATE() ,
		SwitchTo=Case WHEN @SwitchStatusCancel = 18 THEN NULL ELSE SwitchTo END
	WHERE CustomerSubscriptionID=@CustomerSubscriptionID
	
	COMMIT TRANSACTION CustomerSubscriptionUpdate
	
 END TRY
	BEGIN CATCH

      SELECT   @errorProcedure       = Routine_Schema  + '.' + Routine_Name
             , @error                = ERROR_NUMBER()
             , @errorDescription     = ERROR_MESSAGE()
             , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

     ROLLBACK TRANSACTION CustomerSubscriptionUpdate

      RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	END CATCH
END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionUpdate] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionUpdate] not created.',16,1)
	END
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionUpdate1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionUpdate1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionUpdate1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionUpdate1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionUpdate1] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionUpdate1]
(
@CustomerSubscriptionID bigint,
@SubscriptionPlanID		int,
@CustomerPlanStartDate  datetime, 
@CustomerPlanEndDate    datetime,
@NextRenewalDate        datetime,
@RenewalReferenceDate   datetime,
@SubscriptionStatus     tinyint,
@PaymentProcessStatus   tinyint,
@Remarks                varchar(400),
@NextPaymentDate		datetime-- Calculated next payment date value which is passed from DS website in case of updating the card details for suspended customers
)
AS

/*

	Author:			Saminathan
	Date created:	18/08/2011
	Purpose:		Updates Customer subscription Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>
	--exec [tescosubscription].[CustomerSubscriptionUpdate1] 2018,69, null,null,null,null,9,6,'Test remarks-sami for stop'

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    26 Aug 2011		Saminathan						Modified Subs status from Stoppped to Pending Stop
    13 Sep 2011		Saritha K						Modified IF ..ELSE condition
	06 Dec 2012     Robin							Added UTC Date
	04 Jun 2013		Robin							Added NextPaymentDate parameter and added logic for nextpaymentdate
*/
BEGIN

     DECLARE @errorDescription	NVARCHAR(2048)
			,@error				INT
			,@errorProcedure    SYSNAME
			,@errorLine	        INT
 			,@SwitchToExisting INT
			,@SwitchStatusCancel TINYINT
			,@SwitchOrigin VARCHAR(60)
	
	
	BEGIN TRY
	BEGIN TRANSACTION CustomerSubscriptionUpdate
	
       --Updates History when status change
    IF(@SubscriptionStatus is not null)
  BEGIN	
	INSERT INTO tescosubscription.CustomerSubscriptionHistory
					(
					CustomerSubscriptionID,
					SubscriptionStatus,
					Remarks					
					)
		VALUES
					(
					@CustomerSubscriptionID,
					@SubscriptionStatus,
					@Remarks
					)
--Plan Cancel and PendingStop is only from Juvo and not from Web, below is exception
--Plan Pendingstop from web is possible only if it was already PendingStop and Suspended and this is possible only for Installment plans
--Condition to find above is (@NextPaymentDate is null ), from web @NextPaymentDate is not null from Juvo it is Null
IF(@SubscriptionStatus=9 OR @SubscriptionStatus=11) AND @NextPaymentDate is null --When subsription status is cancel update enddate with current date  
  BEGIN  
   SELECT @CustomerPlanEndDate=
	CASE WHEN @SubscriptionStatus=9 THEN 
		getdate() 
	ELSE
		NextRenewalDate
	END,
	@SwitchStatusCancel = 18, @SwitchToExisting=SwitchTo , @SwitchOrigin='Juvo'
	FROM  tescosubscription.CustomerSubscription WHERE CustomerSubscriptionID=@CustomerSubscriptionID 

	IF @SwitchToExisting IS NOT NULL
	BEGIN
	INSERT INTO [tescosubscription].[CustomerSubscriptionSwitchHistory]
			   (
				    [CustomerSubscriptionID]
                   ,[SwitchTo]
                   ,[SwitchStatus]
				   ,[SwitchOrigin]
				   
				)
		SELECT @CustomerSubscriptionID
			,@SwitchToExisting
			,@SwitchStatusCancel
			,@SwitchOrigin
		END

  END
    
 END 


UPDATE tescosubscription.CustomerSubscription 
	SET SubscriptionPlanID=COALESCE(@SubscriptionPlanID,SubscriptionPlanID),
		CustomerPlanStartDate=COALESCE(@CustomerPlanStartDate,CustomerPlanStartDate),
		CustomerPlanEndDate=COALESCE(@CustomerPlanEndDate,CustomerPlanEndDate),
		NextRenewalDate=COALESCE(@NextRenewalDate,NextRenewalDate),
		SubscriptionStatus=COALESCE(@SubscriptionStatus,SubscriptionStatus),
		PaymentProcessStatus=COALESCE(@PaymentProcessStatus,PaymentProcessStatus),
		RenewalReferenceDate=COALESCE(@RenewalReferenceDate,RenewalReferenceDate),  
		UTCUpdatedDateTime=GETUTCDATE() ,
		SwitchTo=Case WHEN @SwitchStatusCancel = 18 THEN NULL ELSE SwitchTo END,
		NextPaymentDate=COALESCE(@NextPaymentDate,NextPaymentDate)
	WHERE CustomerSubscriptionID=@CustomerSubscriptionID
	
	COMMIT TRANSACTION CustomerSubscriptionUpdate
	
 END TRY
	BEGIN CATCH

      SELECT   @errorProcedure       = Routine_Schema  + '.' + Routine_Name
             , @error                = ERROR_NUMBER()
             , @errorDescription     = ERROR_MESSAGE()
             , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

     ROLLBACK TRANSACTION CustomerSubscriptionUpdate

      RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	END CATCH
END


GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionUpdate1] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionUpdate1]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionUpdate1] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionUpdate1] not created.',16,1)
		END
	GOIF OBJECT_ID(N'[tescosubscription].[DeliverySaverNotificationSummary]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[DeliverySaverNotificationSummary]

		IF OBJECT_ID(N'[tescosubscription].[DeliverySaverNotificationSummary]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverNotificationSummary] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverNotificationSummary] not dropped.',16,1)
				
			END
	END
GO
 
CREATE PROCEDURE [tescosubscription].[DeliverySaverNotificationSummary] 
AS
 
 /*

	Author:			Rangan Thulasi
	Date created:	18 Jan 2012
	Purpose:		
	WarmUP Script:	Execute [tescosubscription].[DeliverySaverNotificationSummary]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	27 Jun 2013     Robin                           added new variable and Convert function for planend date

*/

BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE  @CurrentDate DATETIME	
			,@NotifyPeriod TINYINT -- no. of days before which notification has to be sent for expired cards
			,@ActiveSubscriptionStatus TINYINT
			,@RecurringChannelID	TINYINT
			,@SystemFailureStatusID TINYINT
				
			
 
	SELECT  @CurrentDate = GETDATE()	
	       ,@NotifyPeriod = 7
		   ,@ActiveSubscriptionStatus = 8
		   ,@RecurringChannelID = 2	
		   ,@SystemFailureStatusID = 3		   
 --	hard coded values are stored in variables for ease of future changes if any.
	
	SELECT 'Expiry/Payment Reminder' AS MailType
		   ,COUNT(CS.[CustomerSubscriptionID]) MailCount		  
		  
	FROM tescosubscription.CustomerSubscription CS
	WHERE CS.SubscriptionStatus = @ActiveSubscriptionStatus
	AND CS.NextRenewalDate <= DATEADD(DAY, @NotifyPeriod,@CurrentDate)
	AND CS.NextRenewalDate <> CS.EmailSentRenewalDate  --check flag 
	AND CS.NextRenewalDate <  CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101) -- no notification is needed if the subscription is about to end
	
		 
	UNION
	
	SELECT 'Payment Notification'  AS MailType		 
           ,COUNT(CPH.CustomerPaymentHistoryID)  MailCount		   
	FROM tescosubscription.CustomerPaymentHistoryResponse CPHR
		JOIN tescosubscription.CustomerPaymentHistory CPH ON CPHR.CustomerPaymentHistoryID = CPH.CustomerPaymentHistoryID
			AND CPHR.PaymentStatusID <> @SystemFailureStatusID
			AND IsEmailSent = 0 -- check flag
			AND ChannelID = @RecurringChannelID 
	
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[DeliverySaverNotificationSummary] TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[DeliverySaverNotificationSummary]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverNotificationSummary]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverNotificationSummary] not created.',16,1)
		
	END
GO
 

IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPackageSummary]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[DeliverySaverPackageSummary]

		IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPackageSummary]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverPackageSummary] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverPackageSummary] not dropped.',16,1)
				
			END
	END
GO
 

CREATE  PROCEDURE [tescosubscription].[DeliverySaverPackageSummary]  
   
 AS 

/*

	Author:			Rangan Thulasi
	Date created:	18 Jan 2012
	Purpose:		
	WarmUP Script:	Execute [tescosubscription].[DeliverySaverPackageSummary]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	27 Jun 2013     Robin                           Removed old logic and added  CONVERT(VARCHAR(10), GETDATE(), 101)  

*/

   
 BEGIN    
 SET NOCOUNT ON    
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    
    
 DECLARE @StartOfDay DATETIME    
      
 SELECT  @StartOfDay = CONVERT(VARCHAR(10), GETDATE(), 101)     
       
 -- package failure error      
 -- both packages included     
 SELECT PM.PackageName    
    FROM tescosubscription.PackageErrorLog Elog     
  JOIN tescosubscription.PackageExecutionHistory PEH ON Elog.PackageExecutionHistoryID = PEH.PackageExecutionHistoryID    
  JOIN tescosubscription.PackageMaster PM ON PM.PackageID = PEH.PackageID    
  WHERE   PEH.PackageStartTime >= @StartOfDay     
  GROUP BY PM.PackageName           
     
     
END        
   
 GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[DeliverySaverPackageSummary] TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPackageSummary]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverPackageSummary]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverPackageSummary] not created.',16,1)
		
	END
GO
 IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPaymentSummary]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[DeliverySaverPaymentSummary]

		IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPaymentSummary]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverPaymentSummary] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverPaymentSummary] not dropped.',16,1)
				
			END
	END
GO
 
 
 CREATE PROCEDURE [tescosubscription].[DeliverySaverPaymentSummary]       
 
    
 AS  

/*

	Author:			Rangan Thulasi
	Date created:	18 Jan 2012
	Purpose:		
	WarmUP Script:	Execute [tescosubscription].[DeliverySaverPaymentSummary]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	11-5-2012		Saritha  K						Removed parameter Timeinterval
	27-6-2013       Robin                           Removed old logic and added CONVERT(VARCHAR(10), GETDATE(), 101)

*/
  
 BEGIN    
 SET NOCOUNT ON    

 IF 1=2
 BEGIN
	SELECT 1 TotalCount,'                              ' Remarks
 END


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    
    
 DECLARE @StartOfDay DATETIME
  ,@SuccessPaymentProcessStatus TINYINT     
   ,@InProgressPaymentProcessStatus TINYINT    
   ,@SystemFailureStatusID TINYINT    
      
 SELECT  @StartOfDay = CONVERT(VARCHAR(10), GETDATE(), 101)
   ,@SuccessPaymentProcessStatus = 6      
   ,@InProgressPaymentProcessStatus = 5    
   ,@SystemFailureStatusID = 3   
  
  

CREATE TABLE #PaymentProcessed (CustomerPaymentHistoryID BIGINT, PaymentProcessStatus TINYINT)
    
 INSERT INTO #PaymentProcessed    
 SELECT CustomerPaymentHistoryID,PaymentProcessStatus FROM    
     tescosubscription.PackageExecutionHistory PEH  
   JOIN [tescosubscription].CustomerPaymentHistory CPH ON  PEH.PackageStartTime >= @StartOfDay AND CPH.PackageExecutionHistoryID=PEH.PackageExecutionHistoryID    
   JOIN tescosubscription.CustomerSubscription CS ON CS.CustomerSubscriptionID =CPH.CustomerSubscriptionID-- TLog.TransactionRefrenceID    
     

    
      
 -- Successfully processed    
 SELECT COUNT(1) TotalCount,'Payment Process Success' Remarks FROM  #PaymentProcessed PP    
 join tescosubscription.CustomerPaymentHistoryResponse CPH on PP.CustomerPaymentHistoryID = CPH.CustomerPaymentHistoryID    
 WHERE PaymentStatusID <> @SystemFailureStatusID      
     
 UNION ALL    
     
 ---- System failure    
 SELECT COUNT(1) TotalCount, Remarks FROM #PaymentProcessed PP    
 join tescosubscription.CustomerPaymentHistoryResponse CPH on PP.CustomerPaymentHistoryID = CPH.CustomerPaymentHistoryID    
 WHERE PaymentStatusID = @SystemFailureStatusID     
 GROUP BY Remarks     
     
 UNION ALL    
     
 ---- Unknown error    
 SELECT COUNT(1) TotalCount,'Unknown Error' Remarks FROM    
   #PaymentProcessed PP 
 WHERE PP.PaymentProcessStatus= @InProgressPaymentProcessStatus    
   
    
  DROP TABLE #PaymentProcessed
  
     
END     
      
    
    
 GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[DeliverySaverPaymentSummary] TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPaymentSummary]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverPaymentSummary]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverPaymentSummary] not created.',16,1)
		
	END
GO
    
USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[LongSuspendedToCancelledStatusUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[LongSuspendedToCancelledStatusUpdate]

		IF OBJECT_ID(N'[tescosubscription].[LongSuspendedToCancelledStatusUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[LongSuspendedToCancelledStatusUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[LongSuspendedToCancelledStatusUpdate] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[LongSuspendedToCancelledStatusUpdate] 
AS

/*  
    Author:			Saritha Kommineni
	Date created:	25 Apr 2014
	Purpose:		To Cancel long suspended subscriptions
	Behaviour:		
	Usage:			
	Called by:		Job TescoSubscriptionSubscriptionStatusUpdate
	WarmUP Script:	Execute [tescosubscription].[LongSuspendedToCancelledStatusUpdate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/

BEGIN


DECLARE  @SuspendedSubscriptionStatus          TINYINT
		,@CancelledSubscriptionStatus          TINYINT
        ,@SuspendedToCancelledStatusDurtation  VARCHAR(255)
        ,@SwitchStatusCancel                   TINYINT
        ,@errorDescription			           NVARCHAR(2048)
		,@error								   INT
		,@errorProcedure			           SYSNAME
		,@errorLine			                   INT

CREATE TABLE #CustomerSubscriptionID (CustomerSubscriptionID BIGINT, SwitchTo INT)

		SELECT @SuspendedSubscriptionStatus =7 
			  ,@CancelledSubscriptionStatus= 9 
			  ,@SwitchStatusCancel = 18

SELECT @SuspendedToCancelledStatusDurtation = SettingValue FROM [tescosubscription].[ConfigurationSettings] WITH (NOLOCK)
                                              WHERE SettingName = 'SuspendedToCancelledStatusDuration'


		INSERT  INTO #CustomerSubscriptionID
		SELECT CustomerSubscriptionID, 
				CASE WHEN SwitchTo IS NOT NULL
					 THEN 0
					 ELSE SwitchTo 
				END
		FROM tescosubscription.CustomerSubscription WITH (NOLOCK)
		WHERE SubscriptionStatus=@SuspendedSubscriptionStatus
		AND DATEDIFF(DD,NextRenewalDate, GETDATE()) >= @SuspendedToCancelledStatusDurtation

BEGIN TRY
BEGIN TRANSACTION
      
    -- Update tescosubscription.CustomerSubscription

		UPDATE CS
		SET  CustomerplanEndDate = GETUTCDATE()
			,SubscriptionStatus  = @CancelledSubscriptionStatus
			,CS.SwitchTo = CST.SwitchTo
			,UTCUpdatedDateTime  = GETUTCDATE()
		FROM tescosubscription.CustomerSubscription CS WITH (NOLOCK)
		JOIN #CustomerSubscriptionID CST
		ON CS.CustomerSubscriptionID = CST.CustomerSubscriptionID

  -- Insert tescosubscription.CustomerSubscriptionHistory

	
	   INSERT INTO [tescosubscription].[CustomerSubscriptionHistory]
				 ( [CustomerSubscriptionID]
				  ,[SubscriptionStatus]			 
				  ,[Remarks])
	   SELECT      CustomerSubscriptionID
				  ,@CancelledSubscriptionStatus			
				  ,'Cancelled automatically - previously a suspended plan' 
	   FROM  #CustomerSubscriptionID

  -- Insert tescosubscription.CustomerSubscriptionSwitchHistory

		 INSERT INTO tescosubscription.CustomerSubscriptionSwitchHistory
			(
				[CustomerSubscriptionID]
			   ,[SwitchTo]
			   ,[SwitchStatus]
			   ,[SwitchOrigin]					   
			)
		 SELECT CustomerSubscriptionID
			   ,SwitchTo
			   ,@SwitchStatusCancel
			   ,'Job TescoSubscriptionSubscriptionStatusUpdate'   
		 FROM #CustomerSubscriptionID
	  

 COMMIT TRANSACTION

DROP TABLE #CustomerSubscriptionID

	END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		ROLLBACK TRANSACTION      

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
       
	END CATCH

END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[LongSuspendedToCancelledStatusUpdate] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[LongSuspendedToCancelledStatusUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[LongSuspendedToCancelledStatusUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[LongSuspendedToCancelledStatusUpdate] not created.',16,1)
	END
GO



USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[NextpaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[NextpaymentDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[NextpaymentDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[NextpaymentDetailsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[NextpaymentDetailsGet] not dropped.',16,1)
			END
	END
GO 
CREATE PROCEDURE [tescosubscription].[NextpaymentDetailsGet]
(
	@CustomerSubsID BIGINT
)
AS

/*

	Author:			Saminathan
	Date created:	02/04/2014
	Purpose:		Returns next payment details
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<JUVO>

    --Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
*/

	BEGIN
	
	  SET NOCOUNT ON		
		DECLARE @NextPlanID	INT,
		        @CustomerID BIGINT,
                @Suspended  TINYINT,
                @Active     TINYINT,
                @PendingStop TINYINT,
				@CouponPayment TINYINT,
				@CardPayment	TINYINT,
				@UpfrontPayment  TINYINT


        SELECT  @Suspended = 7,
                @Active = 8,
                @PendingStop = 11,
				@CouponPayment=2,
				@CardPayment=1,
				@UpfrontPayment =1
		
		
		SELECT @NextPlanID=COALESCE(SwitchTo,SubscriptionPlanID),
			   @CustomerID=CustomerID
			   FROM tescosubscription.CustomerSubscription WITH (NOLOCK)
			   WHERE CustomerSubscriptionID=@CustomerSubsID
			
		SELECT SP.SubscriptionPlanID as PlanID,
			
			NextRenewalDate AS	'PlanStartDate',
			PlanName,
			PlanTenure,
			PlanAmount,
			SP.PaymentInstallmentID,
			CASE WHEN SP.PaymentInstallmentID <> @UpfrontPayment THEN ROUND(PlanAmount/PlanTenure,2)* InstallmentTenure ELSE NULL END 'InstallmentAmount'	
	        FROM tescosubscription.CustomerSubscription CS WITH (NOLOCK) 
            INNER JOIN  tescosubscription.SubscriptionPlan SP WITH (NOLOCK)
	        ON SP.SubscriptionPlanID=@NextPlanID
			INNER JOIN [tescosubscription].[PaymentInstallment] IP WITH  (NOLOCK)
			ON SP.PaymentInstallmentID =IP.PaymentInstallmentID
	        WHERE CustomerSubscriptionID= @CustomerSubsID 
            AND (SubscriptionStatus IN (@Suspended,@Active) OR (SwitchTo IS NOT NULL AND SubscriptionStatus=@PendingStop  ))
			

		SELECT PaymentModeID,
				PaymentToken
				FROM tescosubscription.CustomerPayment WITH (NOLOCK) 
				WHERE CustomerID=@CustomerID and ((PaymentModeID=@CouponPayment AND IsActive = 1 AND IsFirstPaymentDue = 1 ) 
			    OR (PaymentModeID=@CardPayment AND  IsActive = 1 ))

	
	END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[NextpaymentDetailsGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[NextpaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[NextpaymentDetailsGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[NextpaymentDetailsGet] not created.',16,1)
	END
GO
    






IF OBJECT_ID(N'[tescosubscription].[PackageErrorLogCreate]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[PackageErrorLogCreate]

		IF OBJECT_ID(N'[tescosubscription].[PackageErrorLogCreate]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[PackageErrorLogCreate] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[PackageErrorLogCreate] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[PackageErrorLogCreate] 
(	  
       @ErrorID BIGINT
      ,@PackageExecutionHistoryID BIGINT
      ,@ErrorDescription VARCHAR(1000)
      ,@ErrrorDateTime DATETIME
  )

AS

/*  Author:			Saritha Kommineni
	Date created:	22 Aug 2011
	Purpose:	    To insert PackageError Log details into [tescosubscription].[PackageErrorLog] table
	Behaviour:		
	Usage:			
	Called by:		SSIS PACKAGE RenewCustomerSubscriptions.dtsx
	WarmUP Script:	Execute [tescosubscription].[PackageErrorLogCreate] 

--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
		
*/

BEGIN

	SET NOCOUNT ON;

		INSERT INTO [tescosubscription].[PackageErrorLog]
			(
             [ErrorID]
			 ,[PackageExecutionHistoryID] 
		     ,[ErrorDescription]
			 ,[ErrorDateTime]
             )            
		VALUES	
           (
              @ErrorID
              ,@PackageExecutionHistoryID
              ,@ErrorDescription  
              ,@ErrrorDateTime        		
		   )	
END

 
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PackageErrorLogCreate]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[PackageErrorLogCreate]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[PackageErrorLogCreate] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[PackageErrorLogCreate] not created.',16,1)
		
	END
GO









IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryCreate]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[PackageExecutionHistoryCreate]

		IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryCreate]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[PackageExecutionHistoryCreate] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[PackageExecutionHistoryCreate] not dropped.',16,1)
				
			END
	END
GO

  
CREATE PROCEDURE [tescosubscription].[PackageExecutionHistoryCreate]   
(      
    @PackageID SMALLINT  
     ,@PackageStartTime DATETIME      
)  
  
AS  
  
/*  Author:   Saritha Kommineni  
 Date created: 22 Aug 2011  
 Purpose:     To insert PackageExecution details into [tescosubscription].[PackageExecutionHistory] table  
 Behaviour:    
 Usage:     
 Called by:  SSIS PACKAGE RenewCustomerSubscriptions.dtsx  
 WarmUP Script: Execute [tescosubscription].[PackageExecutionHistoryCreate] 1,'2011-10-10 12:34:56'  
  
--Modifications History--  
 Changed On      Changed By      Defect Ref          Change Description  
 28-09-2011		  Thulasi R                          Renamed sp to PackageExecutionHistoryCreate from PackageExecutionHistorysave  
  
   
*/  
  
BEGIN  
  
 SET NOCOUNT ON;  
  
  INSERT INTO [tescosubscription].[PackageExecutionHistory]            
   (  
    [PackageID]  
      ,[PackageStartTime]  
             ) 
	OUTPUT inserted.PackageExecutionHistoryID        
    VALUES   
           (  
              @PackageID
             ,@PackageStartTime                 
		   ) 


End
  
  
 GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PackageExecutionHistoryCreate]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryCreate]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[PackageExecutionHistoryCreate] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[PackageExecutionHistoryCreate] not created.',16,1)
		
	END
GO





 
  



IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryUpdate]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[PackageExecutionHistoryUpdate]

		IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryUpdate]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[PackageExecutionHistoryUpdate] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[PackageExecutionHistoryUpdate] not dropped.',16,1)
				
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[PackageExecutionHistoryUpdate] 
(	   
        @PackageExecutionHistoryID  BIGINT
       ,@PackageEndtime DATETIME
       ,@statusID TINYINT
)

AS

/*  Author:			Saritha Kommineni
	Date created:	22 Aug 2011
	Purpose:	    To update PackageExecution details into [tescosubscription].[PackageExecutionHistory] table
	Behaviour:		
	Usage:			
	Called by:		
	WarmUP Script:	Execute [tescosubscription].[PackageExecutionHistoryUpdate]  

--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/

BEGIN
SET NOCOUNT ON;

		Update  [tescosubscription].[PackageExecutionHistory]          
		set [PackageEndTime]= @PackageEndtime,
			[statusID] = @statusID
		where PackageExecutionHistoryID = @PackageExecutionHistoryID 

END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PackageExecutionHistoryUpdate]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryUpdate]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[PackageExecutionHistoryUpdate] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[PackageExecutionHistoryUpdate] not created.',16,1)
		
	END
GO




IF OBJECT_ID(N'[tescosubscription].[PaymentInstallmentGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PaymentInstallmentGet]

		IF OBJECT_ID(N'[tescosubscription].[PaymentInstallmentGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PaymentInstallmentGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PaymentInstallmentGet] not dropped.',16,1)
			END
	END
GO



	
	CREATE PROCEDURE [tescosubscription].[PaymentInstallmentGet]
		-- Add the parameters for the stored procedure here
		
	AS
	/*

	Author:			Robin
	Date created:	29/11/2012
	Purpose:		To get list of all PaymentInstallment details  
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 
	12/12/2012	 Robin						  Added  WITH (NOLOCK)
	

*/
	BEGIN
	

		 SET NOCOUNT ON

		  SELECT [PaymentInstallmentID]
			  ,[PaymentInstallmentName]
			 FROM [tescosubscription].[PaymentInstallment] WITH (NOLOCK)
	END





GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PaymentInstallmentGet] TO [SubsUser]
GO


IF OBJECT_ID(N'[tescosubscription].[PaymentInstallmentGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[PaymentInstallmentGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[PaymentInstallmentGet] not created.',16,1)
	END
GO
IF OBJECT_ID(N'[tescosubscription].[PersonalizedSavingsConfigGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[PersonalizedSavingsConfigGet] 

		IF OBJECT_ID(N'[tescosubscription].[PersonalizedSavingsConfigGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[PersonalizedSavingsConfigGet] 
AS

/*

	Author:			Deepmala Trivedi
	Date created:	08 Aug 2013
	Purpose:		To get all the Country Currencies
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<Scheduler>
	WarmUP Script:	NA    
*/

BEGIN

	   SET NOCOUNT ON		
	
	  SELECT [SettingName],
              [SettingValue]
	   FROM   [TescoSubscription].[ConfigurationSettings] (NOLOCK)
	   Where SettingName in ('IsPersonalizeSaving','PersonalizedSavingsAmount')
END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PersonalizedSavingsConfigGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[PersonalizedSavingsConfigGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] not created.',16,1)
		
	END
GO

	IF OBJECT_ID(N'[tescosubscription].[PlanListGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PlanListGet]

		IF OBJECT_ID(N'[tescosubscription].[PlanListGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PlanListGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PlanListGet] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[PlanListGet]
(
	--INPUT PARAMETERS HERE--
	@SubscriptionPlanRefNumber	INT
	,@CountryCode				CHAR(2)
	,@CountryCurrency			CHAR(3)
	,@SubscriptionName			VARCHAR(30) 
	,@BusinessName				VARCHAR(30)
	
)
AS

/*

	Author:			Rajendra Singh
	Date created:	16 Jun 2011
	Purpose:		To get all the Subscription Plan for a given business, subscription Type and region
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<MT/BOA/DBA>
	WarmUP Script:	Execute [tescosubscription].[PlanListGet] 'GB', 'GBP', 'Delivery', 'Grocery'
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	<26 Jul 2011>	<Thulasi>						<Added the fields PlanDescription and Sort Order. The SP Returns the PlanList based on Sort Order>
	<11/12/2012>    <Robin>                         <Added where condition on ln81>
	<12/12/2012>	<Robin>							<Added Order By for midweek plan>
	<12/17/2012>	<Robin>							<Removed select DOW for midweek plan>
*/

BEGIN

	SET NOCOUNT ON
	
	--DECLARE variables here--
	
	--DECLARE TABLE variables here--
	
	IF (@SubscriptionPlanRefNumber >0)
		BEGIN
			SELECT [SubscriptionPlanID]
				  ,[PlanName]
				  ,[PlanDescription]			     
				  ,[PlanTenure]
				  ,[PlanAmount]
				  ,[TermConditions]
				  ,[IsActive]
				  ,[RecurringMonths]
				  ,[PlanMaxUsage]
				  ,[BasketValue]
				  ,[FreePeriod]
				  ,[PlanEffectiveStartDate]
				  ,[PlanEffectiveEndDate]
				  ,[CCM].CountryCurrency	
			FROM tescosubscription.SubscriptionPlan SP WITH (NOLOCK)
			INNER JOIN tescosubscription.CountryCurrencyMap CCM 
			WITH (NOLOCK)ON  SP.SubscriptionPlanID = @SubscriptionPlanRefNumber AND CCM.CountryCurrencyID = SP.CountryCurrencyID
			WHERE SP.SubscriptionPlanID = @SubscriptionPlanRefNumber

			
		END
	ELSE 
		BEGIN

			SELECT [SubscriptionPlanID]
				  ,[PlanName]
				  ,[PlanDescription]
				  ,[PlanTenure]
				  ,[PlanAmount]
				  ,[TermConditions]
				  ,[IsActive]
				  ,[RecurringMonths]
				  ,[PlanMaxUsage]
				  ,[BasketValue]
				  ,[FreePeriod]
				  ,[PlanEffectiveStartDate]
				  ,[PlanEffectiveEndDate]
				  ,[CCM].CountryCurrency
			FROM tescosubscription.SubscriptionPlan SP  WITH (NOLOCK)
			INNER JOIN tescosubscription.CountryCurrencyMap CCM WITH (NOLOCK) ON CCM.CountryCurrencyID = SP.CountryCurrencyID 
																AND CCM.CountryCode	= @CountryCode
																AND CCM.CountryCurrency	= @CountryCurrency
			INNER JOIN tescosubscription.SubscriptionMaster SM  WITH (NOLOCK)ON SM.SubscriptionID = SP.SubscriptionID
																AND	SM.SubscriptionName	= @SubscriptionName
			INNER JOIN tescosubscription.BusinessMaster BM  WITH (NOLOCK)ON BM.BusinessID = SP.BusinessID
																AND BM.BusinessName	= @BusinessName

			ORDER BY [SortOrder]				
		END
END


GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PlanListGet] TO [SubsUser]
GO



IF OBJECT_ID(N'[tescosubscription].[PlanListGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[PlanListGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[PlanListGet] not created.',16,1)
	END
GO
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go
IF OBJECT_ID(N'[tescosubscription].[PlanListGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PlanListGet1]

		IF OBJECT_ID(N'[tescosubscription].[PlanListGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PlanListGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PlanListGet1] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[PlanListGet1]
(
	--INPUT PARAMETERS HERE--
	@SubscriptionPlanRefNumber	INT
	,@CountryCode				CHAR(2)
	,@CountryCurrency			CHAR(3)
	,@SubscriptionName			VARCHAR(30) 
	,@BusinessName				VARCHAR(30)
	
)
AS

/*

	Author:			Robin
	Date created:	11 Dec	2012
	Purpose:		To get all the Subscription Plan for a given business, subscription Type and region
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<MT/BOA/DBA>
	WarmUP Script:	Execute [tescosubscription].[PlanListGet] 'GB', 'GBP', 'Delivery', 'Grocery'
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/

BEGIN

	SET NOCOUNT ON
	
	--DECLARE variables here--
	
	--DECLARE TABLE variables here--
	
	IF (@SubscriptionPlanRefNumber >0)
		BEGIN
			SELECT [SubscriptionPlanID]
				  ,[PlanName]
				  ,[PlanDescription]			     
				  ,[PlanTenure]
				  ,[PlanAmount]
				  ,[TermConditions]
				  ,[IsActive]
				  ,[RecurringMonths]
				  ,[PlanMaxUsage]
				  ,[BasketValue]
				  ,[FreePeriod]
				  ,[PlanEffectiveStartDate]
				  ,[PlanEffectiveEndDate]
				  ,[CCM].CountryCurrency	
			FROM tescosubscription.SubscriptionPlan SP WITH (NOLOCK)
			INNER JOIN tescosubscription.CountryCurrencyMap CCM WITH (NOLOCK) ON 
			CCM.CountryCurrencyID = SP.CountryCurrencyID
			WHERE SP.SubscriptionPlanID = @SubscriptionPlanRefNumber

			SELECT 
				DOW
			FROM tescosubscription.SubscriptionPlan SP WITH (NOLOCK)
			INNER JOIN [Tescosubscription].[SubscriptionPlanSlot] Slot (NOLOCK)  
				ON SP.SubscriptionPlanId = Slot.SubscriptionPlanId
			Where SP.SubscriptionPlanID = @SubscriptionPlanRefNumber
				and SP.IsSlotRestricted = 1
				Order by DOW
		END
	ELSE 
		BEGIN

			SELECT [SubscriptionPlanID]
				  ,[PlanName]
				  ,[PlanDescription]
				  ,[PlanTenure]
				  ,[PlanAmount]
				  ,[TermConditions]
				  ,[IsActive]
				  ,[RecurringMonths]
				  ,[PlanMaxUsage]
				  ,[BasketValue]
				  ,[FreePeriod]
				  ,[PlanEffectiveStartDate]
				  ,[PlanEffectiveEndDate]
				  ,[CCM].CountryCurrency
			FROM tescosubscription.SubscriptionPlan SP  WITH (NOLOCK)
			INNER JOIN tescosubscription.CountryCurrencyMap CCM WITH (NOLOCK) ON CCM.CountryCurrencyID = SP.CountryCurrencyID 
																AND CCM.CountryCode	= @CountryCode
																AND CCM.CountryCurrency	= @CountryCurrency
			INNER JOIN tescosubscription.SubscriptionMaster SM  WITH (NOLOCK)ON SM.SubscriptionID = SP.SubscriptionID
																AND	SM.SubscriptionName	= @SubscriptionName
			INNER JOIN tescosubscription.BusinessMaster BM  WITH (NOLOCK)ON BM.BusinessID = SP.BusinessID
																AND BM.BusinessName	= @BusinessName

			ORDER BY [SortOrder]				
		END
END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PlanListGet1] TO [SubsUser]
GO


IF OBJECT_ID(N'[tescosubscription].[PlanListGet1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[PlanListGet1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[PlanListGet1] not created.',16,1)
	END
GO








IF OBJECT_ID(N'[tescosubscription].[PlanListGet2]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PlanListGet2]

		IF OBJECT_ID(N'[tescosubscription].[PlanListGet2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PlanListGet2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PlanListGet2] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[PlanListGet2]
(
	--INPUT PARAMETERS HERE--
	@SubscriptionPlanRefNumber	INT
    ,@CountryCode				CHAR(2)
	,@CountryCurrency			CHAR(3)
	,@SubscriptionName			VARCHAR(30) 
	,@BusinessName				VARCHAR(30)
	
)
AS

/*

	Author:			Robin
	Date created:	05 MAY 2013
	Purpose:		To get all the Subscription Plan for a given business, subscription Type and region
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		DS
	WarmUP Script:	Execute [tescosubscription].[PlanListGet2] '1','GB', 'GBP', 'Delivery', 'Grocery'
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	30\May\2013     Robin                           Added 2nd block to get subscriptionplan details
	06\June\2013    Robin                           Added InstallmentTenure
	
*/

BEGIN

	IF (@SubscriptionPlanRefNumber >0)
		BEGIN
	      		SELECT [SubscriptionPlanID]
				  ,[PlanName]
				  ,[PlanDescription]			     
				  ,[PlanTenure]
                  ,[PlanAmount]
				  ,CASE 
                  WHEN IP.PaymentInstallmentID <> 1 THEN ROUND(SP.[PlanAmount]/SP.PlanTenure,2)  * InstallmentTenure
                   ELSE NULL  END InstallmentAmount
				  ,[InstallmentTenure]
                  ,[TermConditions]
				  ,[IsActive]
				  ,[RecurringMonths]
				  ,[PlanMaxUsage]                                     
				  ,[BasketValue]
				  ,[FreePeriod]
				  ,[PlanEffectiveStartDate]
				  ,[PlanEffectiveEndDate]
                  ,[IsSlotRestricted]
                  ,IP.[PaymentInstallmentName]
				  ,[CCM].CountryCurrency	
			FROM tescosubscription.SubscriptionPlan SP WITH (NOLOCK)
			INNER JOIN tescosubscription.CountryCurrencyMap CCM WITH (NOLOCK) ON 
			CCM.CountryCurrencyID = SP.CountryCurrencyID
            INNER JOIN tescosubscription.PaymentInstallment IP With(NOLOCK) ON
            SP.PaymentInstallmentID = IP.PaymentInstallmentID
			WHERE SP.SubscriptionPlanID = @SubscriptionPlanRefNumber

			SELECT 
				DOW
			FROM tescosubscription.SubscriptionPlan SP WITH (NOLOCK)
			INNER JOIN [Tescosubscription].[SubscriptionPlanSlot] Slot (NOLOCK)  
				ON SP.SubscriptionPlanId = Slot.SubscriptionPlanId
			Where SP.SubscriptionPlanID = @SubscriptionPlanRefNumber
				and SP.IsSlotRestricted = 1
				Order by DOW
             END

     ELSE 
		BEGIN

			SELECT [SubscriptionPlanID]
				  ,[PlanName]
				  ,[PlanDescription]
				  ,[PlanTenure]
				  ,[PlanAmount]
				  ,[TermConditions]
				  ,[IsActive]
				  ,[RecurringMonths]
				  ,[PlanMaxUsage]
				  ,[BasketValue]
				  ,[FreePeriod]
				  ,[PlanEffectiveStartDate]
				  ,[PlanEffectiveEndDate]
				  ,[CCM].CountryCurrency
			FROM tescosubscription.SubscriptionPlan SP  WITH (NOLOCK)
			INNER JOIN tescosubscription.CountryCurrencyMap CCM WITH (NOLOCK) ON CCM.CountryCurrencyID = SP.CountryCurrencyID 
																AND CCM.CountryCode	= @CountryCode
																AND CCM.CountryCurrency	= @CountryCurrency
			INNER JOIN tescosubscription.SubscriptionMaster SM  WITH (NOLOCK)ON SM.SubscriptionID = SP.SubscriptionID
																AND	SM.SubscriptionName	= @SubscriptionName
			INNER JOIN tescosubscription.BusinessMaster BM  WITH (NOLOCK)ON BM.BusinessID = SP.BusinessID
																AND BM.BusinessName	= @BusinessName

			ORDER BY [SortOrder]				
		END
        END

GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[PlanListGet2] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[PlanListGet2]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[PlanListGet2] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[PlanListGet2] not created.',16,1)
		END
	GO

USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[TescoSubscription].[PlanNameGetByID]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [TescoSubscription].[PlanNameGetByID]

		IF OBJECT_ID(N'[TescoSubscription].[PlanNameGetByID]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [TescoSubscription].[PlanNameGetByID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [TescoSubscription].[PlanNameGetByID] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [TescoSubscription].[PlanNameGetByID]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[PlanNameGetByID]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [TescoSubscription].[PlanNameGetByID]
(
@SubscriptionPlanID	INT
)
AS
BEGIN

	SELECT PlanName 
	FROM tescosubscription.SubscriptionPlan Sp
	WHERE Sp.SubscriptionPlanID = @SubscriptionPlanID
	
	IF(@@ROWCOUNT > 1 OR @@ROWCOUNT = 0)
	BEGIN
		RAISERROR('ERROR - Procedure [TescoSubscription].[PlanNameGetByID]: multiple name found or plan doesn''t exist',16,1)
	END
	

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [TescoSubscription].[PlanNameGetByID] TO [SubsUser]
GO

IF OBJECT_ID(N'[TescoSubscription].[PlanNameGetByID]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [TescoSubscription].[PlanNameGetByID] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [TescoSubscription].[PlanNameGetByID] not created.',16,1)
	END
GOUSE [TescoSubscription]
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
    

 

 
 


USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[RemainingPaymentSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[RemainingPaymentSave]

		IF OBJECT_ID(N'[tescosubscription].[RemainingPaymentSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[RemainingPaymentSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[RemainingPaymentSave] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[RemainingPaymentSave]
(
     @CustomerSubscriptionID BIGINT	
	,@RemainingPayment MONEY
)
AS
/*  
    Author:			Robin
	Date created:	25 Apr 2014
	Purpose:		To save the remaining payment amount into the table  tescosubscription.CustomerPaymentRemainingDetail
	Behaviour:		
	Usage:			Often/Hourly
	Called by:		Subscription Service
	WarmUP Script:	Execute [tescosubscription].[RemainingPaymentSave]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/

BEGIN

SET NOCOUNT ON;	

DECLARE
	 @errorDescription	NVARCHAR(2048)
	,@error				INT
	,@errorProcedure	SYSNAME
	,@errorLine			INT
 
    BEGIN TRY
 
		BEGIN TRANSACTION
		INSERT INTO tescosubscription.CustomerPaymentRemainingDetail
		(
			 CustomerSubscriptionId
			,PaymentRemainingAmount
		)
		VALUES
		(
		 @CustomerSubscriptionID
		,@RemainingPayment
		)

		COMMIT TRANSACTION 
		
	END TRY
	BEGIN CATCH

		 SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
					  , @error                = ERROR_NUMBER()
					  , @errorDescription     = ERROR_MESSAGE()
					  , @errorLine            = ERROR_LINE()
		 FROM  INFORMATION_SCHEMA.ROUTINES
		 WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		 ROLLBACK TRANSACTION 
		 
		 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 
	END CATCH


END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[RemainingPaymentSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[RemainingPaymentSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[RemainingPaymentSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[RemainingPaymentSave] not created.',16,1)
	END
GO





USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[SetCustomerPaymentCouponUsed]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SetCustomerPaymentCouponUsed]

		IF OBJECT_ID(N'[tescosubscription].[SetCustomerPaymentCouponUsed]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed] not dropped.',16,1)
			END
	END
GO 

CREATE PROCEDURE [tescosubscription].[SetCustomerPaymentCouponUsed] 
(
 @CustomerID     BIGINT
 ,@CouponCodes    VARCHAR(MAX)
)
 AS 
 /*   
 Author:   Deepmala Trivedi 
 Date created: 23 Apr 2014 
 Purpose:  To update the customer's payment coupon status  
 Behaviour:  How does this procedure actually work  
 Usage:   Hourly/Often 
 Called by:  <SubscriptionService>  
 WarmUP Script: Execute [BOASubscription].[CountryCurrencyGet] 

 --Modifications History--  
 Changed On   Changed By  Defect Ref  Change Description  23/0
 4/2014        Deepmala    CREATE PROCEDURE  
 20 Aug 2014   Robin       Added Update statement for UTCUpdatedDateTime
 */ 

BEGIN 

SET NOCOUNT ON 
 
    UPDATE CP  
    SET IsActive = 0,
    IsFirstPaymentDue = 0,
	UTCUpdatedDateTime = GETUTCDATE()
    FROM Tescosubscription.CustomerPayment  CP WITH (NOLOCK) 
    JOIN dbo.ConvertListToTable(@CouponCodes,',') CC   
    ON CC.Item = CP.PaymentToken 
    WHERE CustomerId = @CustomerID 

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SetCustomerPaymentCouponUsed] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[SetCustomerPaymentCouponUsed]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed] not created.',16,1)
	END
GO
    IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionBusinessGet] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionBusinessGet]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionBusinessGet]  not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionBusinessGet]  
AS

/*

	Author:			Praneeth Raj
	Date created:	26 July 2011
	Purpose:		To get list of businesses
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionBusinessGet]  

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	26-July-2011	Sheshgiri Balgi		<TFS no.>	Changed	Return Type to xml


*/



BEGIN

	SET NOCOUNT ON			
			SELECT  [BusinessID]   'BusinessID',
				    [BusinessName] 'BusinessName'    
			FROM    [tescosubscription].[BusinessMaster]	
		    FOR XML PATH('BusinessDetail'),TYPE,root('BusinessDetails')
END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionBusinessGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionBusinessGet]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionBusinessGet]  not created.',16,1)
		
	END
GO

IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionBusinessGet1] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionBusinessGet1] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionBusinessGet1] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionBusinessGet1]  
AS

/*
    Author:			Robin John
	Date created:	05 Dec 2012
	Purpose:		To get list of businesses
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [BOASubscription].[CountryCurrencyGet] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
	12/06/2012       Robin							Correction **CREATE PROCEDURE
	12/11/2012		 Robin						    Added NOLOCK	
*/



BEGIN

	SET NOCOUNT ON			
			SELECT  [BusinessID]   'BusinessID',
				    [BusinessName] 'BusinessName'    
			FROM    [tescosubscription].[BusinessMaster] WITH (NOLOCK)
END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionBusinessGet1]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionBusinessGet1] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionBusinessGet1] not created.',16,1)
		
	END
GO
IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionMasterGet]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionMasterGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionMasterGet] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionMasterGet] 
AS

/*

	Author:			Praneeth Raj
	Date created:	26 July 2011
	Purpose:		To get subscriptions master data
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionMasterGet] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	26-July-2011	Sheshgiri Balgi		<TFS no.>	Changed	Return Type to xml
	28-July-2011	Ravi Paladugu					Changed Xml element name from SubscriptionTypeDetail to SubscriptionMasterDetail

*/

BEGIN

			SET NOCOUNT ON	
		
			SELECT [SubscriptionID]   'SubscriptionID',
				   [SubscriptionName] 'SubscriptionName'   
		    FROM   [tescosubscription].[SubscriptionMaster] 
			ORDER BY [SubscriptionName] 
			FOR XML PATH('SubscriptionMasterDetail'),TYPE,root('SubscriptionMasterDetails')	


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionMasterGet]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionMasterGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionMasterGet] not created.',16,1)
		
	END
GO






IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionMasterGet1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionMasterGet1] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionMasterGet1] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionMasterGet1] 
AS

/*
    Author:			Robin John
	Date created:	05 Dec 2012
	Purpose:		To get subscriptions master data
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [BOASubscription].[CountryCurrencyGet] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	12/06/2012       Robin                           Correction *** CREATE PROCEDURE
	12/12/2012		 Robin	                         Added WITH (NOLOCK)

*/

BEGIN

			SET NOCOUNT ON	
		
			SELECT [SubscriptionID]   'SubscriptionID',
				   [SubscriptionName] 'SubscriptionName'   
		    FROM   [tescosubscription].[SubscriptionMaster] WITH (NOLOCK) 
			ORDER BY [SubscriptionName]  
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionMasterGet1]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionMasterGet1] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionMasterGet1] not created.',16,1)
		
	END
GO





IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanCreate]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanCreate] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanCreate]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanCreate]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanCreate]  not dropped.',16,1)
				
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[SubscriptionPlanCreate] 
(
	 @CountryCurrencyID			TINYINT
	,@BusinessID				TINYINT
	,@SubscriptionID		    TINYINT
	,@PlanName					VARCHAR(50)
	,@PlanDescription			VARCHAR(255)
	,@SortOrder					SMALLINT
	,@PlanTenure				INT
	,@PlanEffectiveStartDate    DATETIME
	,@PlanEffectiveEndDate		DATETIME 
	,@PlanAmount				SMALLMONEY		
	,@IsActive					BIT
	,@RecurringMonths			TINYINT
	,@PlanMaxUsage				SMALLINT
	,@BasketValue				SMALLMONEY
	,@FreePeriod				TINYINT	
	,@TermConditions			VARCHAR(255) = Null
	,@LogicErrorOut			    VARCHAR(50) output
)

AS

/*  Author:			Praneeth Raj
	Date created:	27 July 2011
	Purpose:	    To insert subscription plan details into SubscriptionPlan table	
	Behaviour:		
	Usage:			
	Called by:		
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanCreate]

--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	27-July-2011    Sheshgiri Balgi					Removed the unwanted input parameters
	03-Aug-2011		Saritha k						BasketValue datatype changed from decimal to smallmoney
	05-Aug-2011		Saritha K						SortOrder datatype changed from tinyint to smallint
	05-Sep-2011		Saritha K                       Removed Scope identity and used Output clause - Perf Tuning
	05-Jul-2013     Robin                           Increased the datatype for PlanName from 30 to 50
*/

BEGIN

	SET NOCOUNT ON;

	IF EXISTS(SELECT 1 FROM [tescosubscription].[SubscriptionPlan]WHERE [SortOrder] = @SortOrder)
					
		BEGIN
			SET @LogicErrorOut = 'Plan exists with given priority'
		END	
	ELSE

	BEGIN

	INSERT INTO [tescosubscription].[SubscriptionPlan]           
			([CountryCurrencyID]
           ,[BusinessID]
           ,[SubscriptionID]
           ,[PlanName]
           ,[PlanDescription]
           ,[SortOrder]
           ,[PlanTenure]
           ,[PlanEffectiveStartDate]
           ,[PlanEffectiveEndDate]
           ,[PlanAmount]
		   ,[TermConditions]           
           ,[IsActive]
           ,[RecurringMonths]
           ,[PlanMaxUsage]
           ,[BasketValue]
           ,[FreePeriod])       
           OUTPUT Inserted.SubscriptionPlanID    
		   VALUES	
           (
				 @CountryCurrencyID
				,@BusinessID
				,@SubscriptionID
				,@PlanName
				,@PlanDescription
				,@SortOrder
				,@PlanTenure
				,@PlanEffectiveStartDate
				,@PlanEffectiveEndDate
				,@PlanAmount				
				,@TermConditions
				,@IsActive
				,@RecurringMonths
				,@PlanMaxUsage
				,@BasketValue
				,@FreePeriod								
		   )
	
	--SELECT 	SCOPE_IDENTITY() SubscriptionPlanID
		
END

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanCreate]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanCreate]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanCreate]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanCreate]  not created.',16,1)
		
	END
GO





IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanCreate1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanCreate1] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanCreate1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanCreate1]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanCreate1]  not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanCreate1]  
(
	 @CountryCurrencyID			TINYINT
	,@BusinessID				TINYINT
	,@SubscriptionID		    TINYINT
	,@PlanName					VARCHAR(50)
	,@PlanDescription			VARCHAR(255)
	,@SortOrder					SMALLINT
	,@PlanTenure				INT
	,@PlanEffectiveStartDate    DATETIME
	,@PlanEffectiveEndDate		DATETIME 
	,@PlanAmount				SMALLMONEY		
	,@IsActive					BIT
	,@RecurringMonths			TINYINT
	,@PlanMaxUsage				SMALLINT
	,@BasketValue				SMALLMONEY
	,@FreePeriod				TINYINT	
	,@TermConditions			VARCHAR(255) = Null
	,@LogicErrorOut			    VARCHAR(50) output
	,@SlotXML					XML
	,@PaymentInstallmentID		TINYINT
)

AS

/*  Author:			Robin
	Date created:	29 NOv 3012
	Purpose:	    To insert subscription plan details into SubscriptionPlan table	(BACK OFFICE)
	Behaviour:		
	Usage:			
	Called by:		
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanCreate1]
					SELECT @SlotXML='<Slots>
										 <Slot DOW="1"/>
										 <Slot DOW="2"/>
										 <Slot DOW="3"/>
									</Slots>'
   --Modifications History--
	Changed On		Changed By		Defect Ref		                                Change Description
	12/06/12         Robin		                                                   Increased datatype size for planname
*/

BEGIN

SET NOCOUNT ON;

DECLARE @IsSlotRestricted BIT,@ErrorMessage NVARCHAR(2048)

BEGIN TRY

	IF EXISTS(SELECT 1 FROM [tescosubscription].[SubscriptionPlan]WHERE [SortOrder] = @SortOrder)
					
		BEGIN
			SET @LogicErrorOut = 'Plan exists with given priority'
		END	
	ELSE
	BEGIN

		SELECT @IsSlotRestricted= CASE WHEN COUNT(*) = 7 THEN 0 ELSE 1 END FROM(
									SELECT
										DISTINCT T.C.value('@DOW', 'TINYINT') DOW
									FROM  @SlotXML.nodes('Slots/Slot') T(c)) A	

		DECLARE  @ID TABLE(SubscriptionPlanID INT)

		BEGIN TRAN

		INSERT INTO [Tescosubscription].[SubscriptionPlan]           
				([CountryCurrencyID]
			   ,[BusinessID]
			   ,[SubscriptionID]
			   ,[PlanName]
			   ,[PlanDescription]
			   ,[SortOrder]
			   ,[PlanTenure]
			   ,[PlanEffectiveStartDate]
			   ,[PlanEffectiveEndDate]
			   ,[PlanAmount]
			   ,[TermConditions]           
			   ,[IsActive]
			   ,[RecurringMonths]
			   ,[PlanMaxUsage]
			   ,[BasketValue]
			   ,[FreePeriod]
			   ,PaymentInstallmentID
			   ,IsSlotRestricted)       
			   OUTPUT Inserted.SubscriptionPlanID INTO @ID
			   VALUES	
			   (
					 @CountryCurrencyID
					,@BusinessID
					,@SubscriptionID
					,@PlanName
					,@PlanDescription
					,@SortOrder
					,@PlanTenure
					,@PlanEffectiveStartDate
					,@PlanEffectiveEndDate
					,@PlanAmount				
					,@TermConditions
					,@IsActive
					,@RecurringMonths
					,@PlanMaxUsage
					,@BasketValue
					,@FreePeriod
					,@PaymentInstallmentID
					,@IsSlotRestricted
			   )
		
		IF @IsSlotRestricted = 1 
		BEGIN
			INSERT INTO [tescosubscription].[SubscriptionPlanSlot]
			   ([SubscriptionPlanID]
			   ,[DOW])
			SELECT SubscriptionPlanID,T.C.value('@DOW', 'TINYINT') FROM @ID
				CROSS JOIN @SlotXML.nodes('Slots/Slot') T(c)
		END
	
		COMMIT TRAN		

		SELECT SubscriptionPlanID FROM @ID 
	
	END

END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE() 
		
		IF @@TRANCOUNT > 0        
			BEGIN
				ROLLBACK TRAN
			END 

		RAISERROR ('SP - [tescosubscription].[SubscriptionPlanCreate1] Error = (%s)',16,1,@ErrorMessage) 
		
	        
	END CATCH

END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanCreate1]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanCreate1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanCreate1]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanCreate1]  not created.',16,1)
		
	END
GO





IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet]dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet]

(
@SubscriptionPlanID INT
)

AS

/*

	Author:			Saritha kommineni
	Date created:	02 Aug 2011
	Purpose:		To get list of subscriptionPlan details for given SubscriptionPlanID
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanDetailsGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    05/08/2011		Saritha k					    Added comments in the SP
	11/12/2012      Robin		                    Changed from subscriptionPlanDetailsGet to SubscriptionPlanDetailsGet

*/

BEGIN
SET NOCOUNT ON

SELECT [CountryCurrencyID]      'CountryCurrencyID'
      ,[BusinessID]				'BusinessID'
      ,[SubscriptionID]			'SubscriptionID'
      ,[PlanName]				'PlanName'
      ,[PlanDescription]	    'PlanDescription'
      ,[SortOrder]				'SortOrder'
      ,[PlanTenure]				'PlanTenure'
      ,[PlanEffectiveStartDate] 'PlanEffectiveStartDate'
      ,[PlanEffectiveEndDate]	'PlanEffectiveEndDate'
      ,[PlanAmount]				'PlanAmount'
	  ,[TermConditions]         'TermConditions'
      ,[IsActive]			    'IsActive'
      ,[RecurringMonths]		'RecurringMonths'
      ,[PlanMaxUsage]		    'PlanMaxUsage'
      ,[BasketValue]            'BasketValue'
      ,[FreePeriod]             'FreePeriod'
FROM  [tescosubscription].[tescosubscription].[SubscriptionPlan] (NOLOCK)
WHERE [SubscriptionPlanID] = @SubscriptionPlanID
FOR XML PATH('SubscriptionPlan'),TYPE,root('SubscriptionPlans')	


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsGet] TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet]created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet] not created.',16,1)
		
	END
GO


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet1] not dropped.',16,1)
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet1] 
(
@SubscriptionPlanID INT
)

AS

/*

	Author:			Robin
	Date created:	29/11/2012
	Purpose:		To get list of subscriptionPlan details for given SubscriptionPlanID
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanDetailsGet1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		                                               Change Description
	12/06/2012	     Robin	       Added where condition for subscriptionplanid	
	12/06/2012       Robin	       Correction Create Procedure
	

*/

BEGIN
SET NOCOUNT ON
DECLARE 
@ErrorMessage NVARCHAR(2048)


SELECT [SubscriptionPlanID]     'SubscriptionPlanID'
      ,[CountryCurrencyID]      'CountryCurrencyID'
      ,[BusinessID]				'BusinessID'
      ,[SubscriptionID]			'SubscriptionID'
      ,[PlanName]				'PlanName'
      ,[PlanDescription]	    'PlanDescription'
      ,[SortOrder]				'SortOrder'
      ,[PlanTenure]				'PlanTenure'
      ,[PlanEffectiveStartDate] 'PlanEffectiveStartDate'
      ,[PlanEffectiveEndDate]	'PlanEffectiveEndDate'
      ,[PlanAmount]				'PlanAmount'
	  ,[TermConditions]         'TermConditions'
      ,[IsActive]			    'IsActive'
      ,[RecurringMonths]		'RecurringMonths'
      ,[PlanMaxUsage]		    'PlanMaxUsage'
      ,[BasketValue]            'BasketValue'
      ,[FreePeriod]             'FreePeriod'
	  ,PaymentInstallmentID		'PaymentInstallmentID'
	 
FROM  [tescosubscription].[SubscriptionPlan] (NOLOCK)
WHERE [SubscriptionPlanID] = @SubscriptionPlanID


IF @@ROWCOUNT > 0 
BEGIN

IF EXISTS(SELECT 1 FROM  [tescosubscription].[SubscriptionPlan] (NOLOCK)
			WHERE [SubscriptionPlanID] = @SubscriptionPlanID AND ISSlotRestricted=1)
	SELECT DOW FROM [tescosubscription].[SubscriptionPlanSlot] (NOLOCK)
	        WHERE [SubscriptionPlanID] = @SubscriptionPlanID
 
ELSE
	SELECT 1 DOW UNION ALL
	SELECT 2 DOW UNION ALL
	SELECT 3 DOW UNION ALL
	SELECT 4 DOW UNION ALL
	SELECT 5 DOW UNION ALL
	SELECT 6 DOW UNION ALL
	SELECT 7 DOW


END

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsGet1] TO [SubsUser]
GO


IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet1] not created.',16,1)
	END
GO









IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet2]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet2]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet2] not dropped.',16,1)
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet2] 
(
@SubscriptionPlanID INT
)

AS

/*

	Author:			Robin
	Date created:	03/June/2013
	Purpose:		To get list of subscriptionPlan details for given SubscriptionPlanID
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<DS>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanDetailsGet2]

	--Modifications History--
	Changed On		Changed By		Defect Ref		                                               Change Description
	
*/

BEGIN
SET NOCOUNT ON
DECLARE 
@ErrorMessage NVARCHAR(2048),
@UpfrontPayment  TINYINT

SELECT @UpfrontPayment =1


SELECT [SubscriptionPlanID]     'SubscriptionPlanID'
      ,[CountryCurrencyID]      'CountryCurrencyID'
      ,[BusinessID]				'BusinessID'
      ,[SubscriptionID]			'SubscriptionID'
      ,[PlanName]				'PlanName'
      ,[PlanDescription]	    'PlanDescription'
      ,[SortOrder]				'SortOrder'
      ,[PlanTenure]				'PlanTenure'
      ,[PlanEffectiveStartDate] 'PlanEffectiveStartDate'
      ,[PlanEffectiveEndDate]	'PlanEffectiveEndDate'
      ,[PlanAmount]				'PlanAmount'
	  ,[TermConditions]         'TermConditions'
      ,[IsActive]			    'IsActive'
      ,[RecurringMonths]		'RecurringMonths'
      ,[PlanMaxUsage]		    'PlanMaxUsage'
      ,[BasketValue]            'BasketValue'
      ,[FreePeriod]             'FreePeriod'
      ,sp.PaymentInstallmentID		'PaymentInstallmentID'
	  ,IP.[PaymentInstallmentName] 'PaymentInstallmentName'
      ,CASE WHEN SP.PaymentInstallmentID <> @UpfrontPayment THEN ROUND(PlanAmount/PlanTenure,2)* InstallmentTenure ELSE NULL END 'InstallmentAmount'
	 
FROM  [tescosubscription].[SubscriptionPlan] SP (NOLOCK)
INNER JOIN [tescosubscription].[PaymentInstallment] IP (NOLOCK)
ON SP.PaymentInstallmentID = IP.PaymentInstallmentID 
WHERE [SubscriptionPlanID] = @SubscriptionPlanID


IF @@ROWCOUNT > 0 
BEGIN

IF EXISTS(SELECT 1 FROM  [tescosubscription].[SubscriptionPlan] (NOLOCK)
			WHERE [SubscriptionPlanID] = @SubscriptionPlanID AND ISSlotRestricted=1)
	SELECT DOW FROM [tescosubscription].[SubscriptionPlanSlot] (NOLOCK)
	        WHERE [SubscriptionPlanID] = @SubscriptionPlanID
 
ELSE
	SELECT 1 DOW UNION ALL
	SELECT 2 DOW UNION ALL
	SELECT 3 DOW UNION ALL
	SELECT 4 DOW UNION ALL
	SELECT 5 DOW UNION ALL
	SELECT 6 DOW UNION ALL
	SELECT 7 DOW


END

END


GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsGet2] TO [SubsUser]

GO

IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet2]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet2] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet2] not created.',16,1)
	END
GO



IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGetXML]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGetXML] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGetXML]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGetXML]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGetXML]  not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGetXML] 

(
@SubscriptionPlanID INT
)

AS

/*

	Author:			Robin
	Date created:	29/11/2012
	Purpose:		To get list of subscriptionPlan details for given SubscriptionPlanID
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[subscriptionPlanDetailsGet1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		                                Change Description
	12/12/2012		Robin													        corrected SubscriptionPlanDetailsGetXML to SubscriptionPlanDetailsGetXMLL

*/

BEGIN
SET NOCOUNT ON

DECLARE @SlotXML XML
 
SELECT @SlotXML='<Slots>
  <Slot DOW="1" />
  <Slot DOW="2" />
  <Slot DOW="3" />
  <Slot DOW="4" />
  <Slot DOW="5" />
  <Slot DOW="6" />
  <Slot DOW="7" />
</Slots>'


SELECT [CountryCurrencyID]      'CountryCurrencyID'
      ,[BusinessID]				'BusinessID'
      ,[SubscriptionID]			'SubscriptionID'
      ,[PlanName]				'PlanName'
      ,[PlanDescription]	    'PlanDescription'
      ,[SortOrder]				'SortOrder'
      ,[PlanTenure]				'PlanTenure'
      ,[PlanEffectiveStartDate] 'PlanEffectiveStartDate'
      ,[PlanEffectiveEndDate]	'PlanEffectiveEndDate'
      ,[PlanAmount]				'PlanAmount'
	  ,[TermConditions]         'TermConditions'
      ,[IsActive]			    'IsActive'
      ,[RecurringMonths]		'RecurringMonths'
      ,[PlanMaxUsage]		    'PlanMaxUsage'
      ,[BasketValue]            'BasketValue'
      ,[FreePeriod]             'FreePeriod'
	  ,PaymentInstallmentID		'PaymentInstallmentID'
	  ,CASE WHEN ISSlotRestricted = 1 THEN
		(SELECT [DOW] '@DOW'
		 FROM [tescosubscription].[SubscriptionPlanSlot]
			WHERE [SubscriptionPlanID] = @SubscriptionPlanID
			FOR XML PATH('Slot'),TYPE,root('Slots')	)
		ELSE
		 @SlotXML
		END 
FROM  [tescosubscription].[SubscriptionPlan] (NOLOCK)
WHERE [SubscriptionPlanID] = @SubscriptionPlanID
FOR XML PATH('SubscriptionPlan'),TYPE,root('SubscriptionPlans')	


END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsGetXML]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGetXML]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGetXML]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGetXML]  not created.',16,1)
		
	END
GO







IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsUpdate]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate]dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsUpdate]

		@SubscriptionPlanID	int  ,
		@CountryCurrencyID tinyint ,
		@BusinessID tinyint ,
		@SubscriptionID tinyint ,
		@PlanName varchar(50) ,
		@PlanDescription varchar(255)  ,
		@SortOrder smallint ,
		@PlanTenure int ,
		@PlanEffectiveStartDate datetime ,
		@PlanEffectiveEndDate datetime ,
		@PlanAmount smallmoney ,
		@IsActive bit ,
		@RecurringMonths tinyint ,
		@PlanMaxUsage smallint  ,
		@BasketValue smallmoney ,
		@FreePeriod tinyint ,
		@TermConditions varchar(500) = Null,
		@LogicErrorOut varchar(100) output

AS

/*  Author:			Saritha Kommineni
	Date created:	09 Aug 2011
	Purpose:	    To update subscription plan details into SubscriptionPlan table	
	Behaviour:		
	Usage:			
	Called by:		
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanCreate]

--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	05/07/2013      Robin                           Increase the datatype for PlanName from 30 to 50	
*/

BEGIN

	SET NOCOUNT ON

DECLARE @CurrentUTCDate datetime
SET		@CurrentUTCDate = GETUTCDATE()

IF EXISTS(SELECT 1 FROM [tescosubscription].[SubscriptionPlan] WHERE SubscriptionPlanID <> @SubscriptionPlanID and sortorder =  @sortorder)
BEGIN
	 SET @LogicErrorOut = 'Sort Order already exists'
END

ELSE IF EXISTS(SELECT 1 FROM [tescosubscription].[SubscriptionPlan] WHERE SubscriptionPlanID = @SubscriptionPlanID)
				
BEGIN

	UPDATE  tescosubscription.SubscriptionPlan
	SET		CountryCurrencyID =COALESCE(@CountryCurrencyID,CountryCurrencyID),
			BusinessID		  =COALESCE(@BusinessID,BusinessID),
			SubscriptionID	  =COALESCE(@SubscriptionID,SubscriptionID),
			PlanName          =COALESCE(@PlanName,PlanName),
			PlanDescription   =COALESCE(@PlanDescription,PlanDescription),
            SortOrder         =COALESCE(@SortOrder,SortOrder),
			PlanTenure        =COALESCE(@PlanTenure,PlanTenure),
			PlanEffectiveStartDate =COALESCE(@PlanEffectiveStartDate,PlanEffectiveStartDate),
			PlanEffectiveEndDate   =COALESCE(@PlanEffectiveEndDate,PlanEffectiveEndDate),
			PlanAmount			   =COALESCE(@PlanAmount,PlanAmount),
			TermConditions         =COALESCE(@TermConditions,TermConditions),
			IsActive               =COALESCE(@IsActive,IsActive),
			RecurringMonths        =COALESCE(@RecurringMonths,RecurringMonths),
			PlanMaxUsage           =COALESCE(@PlanMaxUsage,PlanMaxUsage),
			BasketValue            =COALESCE(@BasketValue,BasketValue),
			FreePeriod             =COALESCE(@FreePeriod,FreePeriod),
			UTCUpdatedDateTime     =@CurrentUTCDate
	WHERE	SubscriptionPlanID     = @SubscriptionPlanID

    SET		@LogicErrorOut = 'Details Updated successfully  '
END

ELSE 
BEGIN
       SET @LogicErrorOut = 'SubscriptionPlanID does not exist'
 END

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsUpdate]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate]created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate] not created.',16,1)
		
	END
GO


IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsUpdate1] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate1] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate1] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsUpdate1]

		@SubscriptionPlanID	int  ,
		@CountryCurrencyID tinyint ,
		@BusinessID tinyint ,
		@SubscriptionID tinyint ,
		@PlanName varchar(50) ,
		@PlanDescription varchar(255)  ,
		@SortOrder smallint ,
		@PlanTenure int ,
		@PlanEffectiveStartDate datetime ,
		@PlanEffectiveEndDate datetime ,
		@PlanAmount smallmoney ,
		@IsActive bit ,
		@RecurringMonths tinyint ,
		@PlanMaxUsage smallint  ,
		@BasketValue smallmoney ,
		@FreePeriod tinyint ,
		@TermConditions varchar(500) = Null,
		@LogicErrorOut varchar(100) output,
        @SlotXML					XML,
	    @PaymentInstallmentID		TINYINT
 AS

/*  Author:			Robin
	Date created:	29/11/2012
	Purpose:	    To update subscription plan details into SubscriptionPlan table	
	Behaviour:		
	Usage:			
	Called by:		
    Script:	Execute [tescosubscription].[SubscriptionPlanDetailsUpdate1]

--Modifications History--
	Changed On		Changed By		Defect Ref		                                               Change Description
	12/06/2012	     Robin	       Removed 'Details Updated successfully' from logic error 
	                               since it is not caputed 
    12/06/12         Robin		   Correction ** CREATE PROCEDURE
*/

BEGIN

	SET NOCOUNT ON

DECLARE @CurrentUTCDate datetime, @IsSlotRestricted BIT,@ErrorMessage NVARCHAR(2048)
SET		@CurrentUTCDate = GETUTCDATE()

BEGIN TRY

IF EXISTS(SELECT 1 FROM [tescosubscription].[SubscriptionPlan] WHERE SubscriptionPlanID <> @SubscriptionPlanID and sortorder =  @sortorder)
BEGIN
	 SET @LogicErrorOut = 'Sort Order already exists'
END

ELSE IF EXISTS(SELECT 1 FROM [tescosubscription].[SubscriptionPlan] WHERE SubscriptionPlanID = @SubscriptionPlanID)
				
BEGIN
SELECT @IsSlotRestricted= CASE WHEN COUNT(*) = 7 THEN 0 ELSE 1 END FROM(
									SELECT
										DISTINCT T.C.value('@DOW', 'TINYINT') DOW
									FROM  @SlotXML.nodes('Slots/Slot') T(c)) A	

    BEGIN TRAN

	UPDATE  tescosubscription.SubscriptionPlan
	SET		CountryCurrencyID =COALESCE(@CountryCurrencyID,CountryCurrencyID),
			BusinessID		  =COALESCE(@BusinessID,BusinessID),
			SubscriptionID	  =COALESCE(@SubscriptionID,SubscriptionID),
			PlanName          =COALESCE(@PlanName,PlanName),
			PlanDescription   =COALESCE(@PlanDescription,PlanDescription),
            SortOrder         =COALESCE(@SortOrder,SortOrder),
			PlanTenure        =COALESCE(@PlanTenure,PlanTenure),
			PlanEffectiveStartDate =COALESCE(@PlanEffectiveStartDate,PlanEffectiveStartDate),
			PlanEffectiveEndDate   =COALESCE(@PlanEffectiveEndDate,PlanEffectiveEndDate),
			PlanAmount			   =COALESCE(@PlanAmount,PlanAmount),
			TermConditions         =COALESCE(@TermConditions,TermConditions),
			IsActive               =COALESCE(@IsActive,IsActive),
			RecurringMonths        =COALESCE(@RecurringMonths,RecurringMonths),
			PlanMaxUsage           =COALESCE(@PlanMaxUsage,PlanMaxUsage),
			BasketValue            =COALESCE(@BasketValue,BasketValue),
			FreePeriod             =COALESCE(@FreePeriod,FreePeriod),
			UTCUpdatedDateTime     =@CurrentUTCDate,
            IsSlotRestricted	   =@IsSlotRestricted,
            PaymentInstallmentID   = @PaymentInstallmentID
	WHERE	SubscriptionPlanID     = @SubscriptionPlanID

	IF @IsSlotRestricted = 1 
	BEGIN
		INSERT INTO [tescosubscription].[SubscriptionPlanSlot]
		   ([SubscriptionPlanID]
		   ,[DOW])
		SELECT @SubscriptionPlanID,T.C.value('@DOW', 'TINYINT')  
			FROM @SlotXML.nodes('Slots/Slot') T(c)
			LEFT JOIN [tescosubscription].[SubscriptionPlanSlot] Slot
				ON SubscriptionPlanID=@SubscriptionPlanID
					AND T.C.value('@DOW', 'TINYINT') =DOW
			WHERE SubscriptionPlanID IS NULL

		DELETE Slot
			FROM [tescosubscription].[SubscriptionPlanSlot] Slot
			LEFT JOIN  @SlotXML.nodes('Slots/Slot') T(c)
				ON T.C.value('@DOW', 'TINYINT') =DOW
			WHERE  SubscriptionPlanID=@SubscriptionPlanID
					AND T.C.value('@DOW', 'TINYINT') IS NULL
			
	END
	ELSE IF EXISTS(SELECT 1 FROM [tescosubscription].[SubscriptionPlanSlot] (NOLOCK) WHERE SubscriptionPlanID=@SubscriptionPlanID )
	BEGIN
		DELETE Slot
			FROM [tescosubscription].[SubscriptionPlanSlot] Slot
		WHERE SubscriptionPlanID=@SubscriptionPlanID
	END

		
		COMMIT TRAN		

        SET		@LogicErrorOut = ''
			 	
		END

ELSE 
BEGIN
       SET @LogicErrorOut = 'SubscriptionPlanID does not exist'
END

END TRY
BEGIN CATCH
	SELECT @ErrorMessage = ERROR_MESSAGE()
	
	IF @@TRANCOUNT > 0        
		BEGIN
			ROLLBACK TRAN
		END 

	RAISERROR ('SP - [tescosubscription].[SubscriptionPlanDetailsUpdate1] Error = (%s)',16,1,@ErrorMessage) 
	
        
END CATCH


   
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsUpdate1]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate1] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate1] not created.',16,1)
		
	END
GO


 




IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanGetAll] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[SubscriptionPlanGetAll]


AS

/*

	Author:			Saritha kommineni
	Date created:	02 Aug 2011
	Purpose:		To get all SubscriptionPlans
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanGetAll] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    05/08/2011		Ravi Paladugu					added [PlanEffectiveStartDate],[PlanEffectiveEndDate],[IsActive],[SortOrder] in select list
	05/08/2011		Ravi Paladugu					added Order by clause for SortOrder

*/
BEGIN 

SET NOCOUNT ON

SELECT	SP.[SubscriptionPlanID] 'SubscriptionPlanID'
		,SP.[PlanName]   'PlanName'
		,SP.[PlanTenure] 'PlanTenure'
		,SP.[PlanAmount] 'PlanAmount'
		,BM.[BusinessName] 'BusinessType'
        ,SM.[SubscriptionName]  'SubscriptionType'
		,SP.[PlanEffectiveStartDate] 'PlanEffectiveStartDate'
		,SP.[PlanEffectiveEndDate] 'PlanEffectiveEndDate'
		,SP.[IsActive] 'IsActive'
		,SP.[SortOrder] 'SortOrder'
FROM    [tescosubscription].[tescosubscription].[SubscriptionPlan] SP (NOLOCK)
INNER JOIN [tescosubscription].[tescosubscription].[BusinessMaster] BM  (NOLOCK)
ON		SP.[BusinessID]= BM.[BusinessID] 
INNER JOIN [tescosubscription].[tescosubscription].[SubscriptionMaster] SM  (NOLOCK)
ON      SP.[SubscriptionID]= SM.[SubscriptionID]
order by SP.[SortOrder]
FOR XML PATH('SubscriptionPlan'),TYPE,root('SubscriptionPlans')

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanGetAll]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll] not created.',16,1)
		
	END
GO
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanGetAll1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll1] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll1] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanGetAll1]


AS

/*

	Author:			Robin John
	Date created:	05 Dec 2012
	Purpose:		To get all SubscriptionPlans
	Behaviour:		How does this procedure actually work
	 
	Called by:		<BOA>
	Script:	Execute [tescosubscription].[SubscriptionPlanGetAll1] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    12/06/2012		Robin							Correction **CREATE PROCEDURE
	13/12/2012		Robin							Granted permissions
*/
BEGIN 

SET NOCOUNT ON

SELECT [SubscriptionPlanID] 
      ,[CountryCurrencyID]       
	  ,[BusinessID]				 
	  ,[SubscriptionID]			 
	  ,[PlanName]				 
	  ,[PlanDescription]	    
	  ,[SortOrder]				 
	  ,[PlanTenure]				 
	  ,[PlanEffectiveStartDate]  
	  ,[PlanEffectiveEndDate]	 
	  ,[PlanAmount]				 
	  ,[TermConditions]         
	  ,[IsActive]			    
	  ,[RecurringMonths]		 
	  ,[PlanMaxUsage]		    
	  ,[BasketValue]             
	  ,[FreePeriod]              
	  ,[PaymentInstallmentID]	 
		 
FROM    [tescosubscription].[tescosubscription].[SubscriptionPlan] (NOLOCK) 

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanGetAll1]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll1] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll1] not created.',16,1)
		
	END
GO







 
USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[SuspendedToCancelledStatusUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SuspendedToCancelledStatusUpdate]

		IF OBJECT_ID(N'[tescosubscription].[SuspendedToCancelledStatusUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SuspendedToCancelledStatusUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SuspendedToCancelledStatusUpdate] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[SuspendedToCancelledStatusUpdate] 
AS

/*  
    Author:			Saritha Kommineni
	Date created:	25 Apr 2014
	Purpose:		To Cancel long suspended subscriptions
	Behaviour:		
	Usage:			
	Called by:		Job TescoSubscriptionSubscriptionStatusUpdate
	WarmUP Script:	Execute [tescosubscription].SuspendedToCancelledStatusUpdate

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/

BEGIN


DECLARE  @SuspendedSubscriptionStatus          TINYINT
		,@CancelledSubscriptionStatus          TINYINT
        ,@SuspendedToCancelledStatusDurtation  VARCHAR(255)
        ,@SwitchStatusCancel                   TINYINT
        ,@errorDescription			           NVARCHAR(2048)
		,@error								   INT
		,@errorProcedure			           SYSNAME
		,@errorLine			                   INT

CREATE TABLE #CustomerSubscriptionID (CustomerSubscriptionID BIGINT, SwitchTo INT)

SELECT @SuspendedSubscriptionStatus =7 
	  ,@CancelledSubscriptionStatus= 9 
      ,@SwitchStatusCancel = 18

SELECT @SuspendedToCancelledStatusDurtation = SettingValue FROM [tescosubscription].[ConfigurationSettings] WITH (NOLOCK)
       WHERE SettingName = 'SuspendedToCancelledStatusDuration'


	INSERT  INTO #CustomerSubscriptionID
	SELECT CustomerSubscriptionID, 
			CASE WHEN SwitchTo IS NOT NULL
				 THEN SwitchTo
				 ELSE 0
			END
	FROM tescosubscription.CustomerSubscription WITH (NOLOCK)
	WHERE SubscriptionStatus=@SuspendedSubscriptionStatus
	AND DATEDIFF(DD,NextRenewalDate, GETDATE()) >= @SuspendedToCancelledStatusDurtation

BEGIN TRY
BEGIN TRANSACTION
      
    -- Update tescosubscription.CustomerSubscription

		UPDATE CS
		SET  CustomerplanEndDate = GETUTCDATE()
			,SubscriptionStatus  = @CancelledSubscriptionStatus
			,CS.SwitchTo = NULL
			,UTCUpdatedDateTime  = GETUTCDATE()
		FROM tescosubscription.CustomerSubscription CS WITH (NOLOCK)
		JOIN #CustomerSubscriptionID CST
		ON CS.CustomerSubscriptionID = CST.CustomerSubscriptionID

  -- INsert tescosubscription.CustomerSubscriptionHistory

	
	   INSERT INTO [tescosubscription].[CustomerSubscriptionHistory]
				 ( [CustomerSubscriptionID]
				  ,[SubscriptionStatus]			 
				  ,[Remarks])
	   SELECT      CustomerSubscriptionID
				  ,@CancelledSubscriptionStatus			
				  ,'Cancelled automatically - previously a suspended plan' 
	   FROM  #CustomerSubscriptionID

  -- Insert tescosubscription.CustomerSubscriptionSwitchHistory

		 INSERT INTO tescosubscription.CustomerSubscriptionSwitchHistory
			(
				[CustomerSubscriptionID]
			   ,[SwitchTo]
			   ,[SwitchStatus]
			   ,[SwitchOrigin]					   
			)
		 SELECT CustomerSubscriptionID
			   ,SwitchTo
			   ,@SwitchStatusCancel
			   ,'Job TescoSubscriptionSubscriptionStatusUpdate'   
		 FROM #CustomerSubscriptionID
		 WHERE SwitchTo <> 0
  

 COMMIT TRANSACTION

DROP TABLE #CustomerSubscriptionID

	END TRY
	BEGIN CATCH

      SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
                  , @error                = ERROR_NUMBER()
                  , @errorDescription     = ERROR_MESSAGE()
                  , @errorLine            = ERROR_LINE()
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		ROLLBACK TRANSACTION      

	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
       
	END CATCH

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SuspendedToCancelledStatusUpdate] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[SuspendedToCancelledStatusUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[SuspendedToCancelledStatusUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[SuspendedToCancelledStatusUpdate] not created.',16,1)
	END
GO




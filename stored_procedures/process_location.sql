CREATE DEFINER=`root`@`localhost` PROCEDURE `process_location`(IN p_FBUID VARCHAR(255))
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_account_id INT;
    DECLARE v_location VARCHAR(255);
	DECLARE v_location_id INT;
    
    SELECT person_id, account_id INTO v_person_id, v_account_id
    FROM social_account
    WHERE FBUID = p_FBUID;
    
	SELECT location INTO v_location
    FROM SM_data_feed
    WHERE SMUID = p_FBUID;
    
	IF v_location IS NOT NULL THEN
	SELECT location_id INTO v_location_id
	FROM address
	WHERE person_id = v_person_id AND location = v_location;

		IF v_location_id IS NULL THEN
			INSERT INTO address (person_id, account_id, location)
			VALUES (v_person_id, v_account_id, v_location);
		END IF;
	END IF;
END
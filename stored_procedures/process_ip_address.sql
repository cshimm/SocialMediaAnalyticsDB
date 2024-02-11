CREATE PROCEDURE `process_ip_address` ()
BEGIN
    DECLARE v_ip_address VARCHAR(255);
    SELECT ip_address INTO v_ip_address
    FROM SM_data_feed;

    -- If ip_address is null, place default value
    IF v_ip_address IS NULL THEN
        SET v_ip_address = '0.0.0.0'; -- Default IP address value
    END IF;

    -- Remove non-number characters from ip_address
    SET v_ip_address = REPLACE(REGEXP_REPLACE(v_ip_address, '[^0-9]+', ''), '.', '');

    -- Insert new ip_address record into ip_address table
    INSERT INTO ip_address_table (ip_address) VALUES (v_ip_address);
END 

-- PROPERTY TABLE
CREATE TABLE IF NOT EXISTS property (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    property_title VARCHAR(255),
    address VARCHAR(255),
    market VARCHAR(100),
    flood VARCHAR(50),
    street_address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip VARCHAR(20),
    property_type VARCHAR(100),
    highway VARCHAR(100),
    train VARCHAR(100),
    tax_rate DECIMAL(10,2),
    sqft_basement INT,
    htw VARCHAR(100),
    pool VARCHAR(100),
    commercial VARCHAR(100),
    water VARCHAR(100),
    sewage VARCHAR(100),
    year_built INT,
    sqft_mu INT,
    sqft_total INT,
    parking VARCHAR(100),
    bed INT,
    bath DECIMAL(3,1),
    basement_yes_no VARCHAR(10),
    layout VARCHAR(100),
    rent_restricted VARCHAR(10),
    neighborhood_rating INT,
    latitude DOUBLE,
    longitude DOUBLE,
    subdivision VARCHAR(100),
    school_average DECIMAL(3,2)
);

-- LEADS TABLE
CREATE TABLE IF NOT EXISTS leads (
    lead_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT,
    reviewed_status VARCHAR(100),
    most_recent_status VARCHAR(100),
    source VARCHAR(100),
    occupancy VARCHAR(50),
    net_yield DECIMAL(10,2),
    irr DECIMAL(10,2),
    selling_reason TEXT,
    seller_retained_broker VARCHAR(10),
    final_reviewer VARCHAR(100),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
);

-- VALUATION TABLE
CREATE TABLE IF NOT EXISTS valuation (
    valuation_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT,
    previous_rent DECIMAL(10,2),
    list_price DECIMAL(10,2),
    zestimate DECIMAL(10,2),
    arv DECIMAL(10,2),
    expected_rent DECIMAL(10,2),
    rent_zestimate DECIMAL(10,2),
    low_fmr DECIMAL(10,2),
    high_fmr DECIMAL(10,2),
    redfin_value DECIMAL(10,2),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
);

-- HOA TABLE
CREATE TABLE IF NOT EXISTS hoa (
    hoa_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT,
    hoa TEXT,
    hoa_flag VARCHAR(10),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
);

-- REHAB TABLE
CREATE TABLE IF NOT EXISTS rehab (
    rehab_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT,
    underwriting_rehab DECIMAL(10,2),
    rehab_calculation TEXT,
    paint VARCHAR(10),
    flooring_flag VARCHAR(10),
    foundation_flag VARCHAR(10),
    roof_flag VARCHAR(10),
    hvac_flag VARCHAR(10),
    kitchen_flag VARCHAR(10),
    bathroom_flag VARCHAR(10),
    appliances_flag VARCHAR(10),
    windows_flag VARCHAR(10),
    landscaping_flag VARCHAR(10),
    trashout_flag VARCHAR(10),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
);

-- TAXES TABLE
CREATE TABLE IF NOT EXISTS taxes (
    tax_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT,
    taxes DECIMAL(10,2),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
);

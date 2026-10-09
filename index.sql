CREATE TABLE objects (
    id BIGSERIAL PRIMARY KEY,
    source VARCHAR(100) NOT NULL,
    external_id VARCHAR(255) NOT NULL,
    value NUMERIC NOT NULL,
    source_timestamp TIMESTAMPTZ,
    received_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    raw_data JSONB NOT NULL,

    UNIQUE(source, external_id, source_timestamp)
);

CREATE TABLE validation_errors (
    id BIGSERIAL PRIMARY KEY,
    source VARCHAR(100),
    external_id VARCHAR(255),
    error_type VARCHAR(100),
    error_message TEXT NOT NULL,
    raw_data JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_objects_source_timestamp
    ON objects(source, source_timestamp);

CREATE INDEX idx_validation_errors_created_at
    ON validation_errors(created_at);
// Select license based on the crate type
//
// These are just defaults, if you don't like these license choices, then, as
// the copyright holder, you are allowed to remove them completely and/or swap
// them out for other licenses.
let license = switch variable::get("crate_type") {
    "bin" => {
        file::delete("LICENSE-MIT");
        file::delete("LICENSE-APACHE");

        "AGPL-3.0-only"
    }

    "lib" => {
        file::delete("LICENSE-AGPL");

        "MIT OR Apache-2.0"
    }

    _ => {
        throw "unknown crate type";
    }
};

variable::set("license", license);

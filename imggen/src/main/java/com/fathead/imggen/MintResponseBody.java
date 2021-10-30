package com.fathead.imggen;

import lombok.Data;

@Data
public class MintResponseBody {
    private boolean success;
    private String message;
    private String imageURI;

    public MintResponseBody(Boolean success, String message, String imageURI){
        this.success=success;
        this.message=message;
        this.imageURI=imageURI;
    }
}

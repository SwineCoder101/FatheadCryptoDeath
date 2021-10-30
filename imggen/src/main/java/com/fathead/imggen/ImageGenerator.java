package com.fathead.imggen;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class ImageGenerator {

    public static String generateImgURI(BufferedImage img) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(img, "png", baos);
        byte[] bytes = baos.toByteArray();
        String base64bytes = new String(Base64.getEncoder().encode(bytes), StandardCharsets.UTF_8);
        String src = "data:image/png;base64," + base64bytes;
//        System.out.println(src);
        return src;
    }

    public static void generateImage(String filepath) {
        //image dimension
        int width = 640;
        int height = 320;
        //create buffered image object img
        BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        //file object
        File f = null;
        //create random image pixel by pixel
        for(int y = 0; y < height; y++){
            for(int x = 0; x < width; x++){
                int a = (int)(Math.random()*256); //alpha
                int r = (int)(Math.random()*256); //red
                int g = (int)(Math.random()*256); //green
                int b = (int)(Math.random()*256); //blue

                int p = (a<<24) | (r<<16);// | (g<<8) | b; //pixel

                img.setRGB(x, y, p);
            }
        }
        //write image
        try{
            f = new File(filepath);
            File imgUriFile = new File("C:\\dev\\imggen\\src\\main\\resources\\Output.txt");
            FileWriter fileWriter = new FileWriter(imgUriFile);
            fileWriter.write(generateImgURI(img));
            ImageIO.write(img, "png", f);
        }catch(IOException e){
            System.out.println("Error: " + e);
        }
    }//main() ends here
}

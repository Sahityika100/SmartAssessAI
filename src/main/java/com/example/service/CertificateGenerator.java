package com.example.service;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import javax.servlet.http.HttpServletResponse;

public class CertificateGenerator {

    public static void generateCertificate(HttpServletResponse response, String name, String course, double score) {
        // Landscape orientation for a professional look
        Document document = new Document(PageSize.A4.rotate(), 50, 50, 50, 50);

        try {
            PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
            
            // Border and Logo Page Event
            writer.setPageEvent(new PdfPageEventHelper() {
                @Override
                public void onEndPage(PdfWriter writer, Document document) {
                    PdfContentByte canvas = writer.getDirectContent();
                    Rectangle rect = writer.getPageSize();
                    
                    // 1. Draw Golden Border
                    rect.setLeft(20);
                    rect.setBottom(20);
                    rect.setRight(rect.getWidth() - 20);
                    rect.setTop(rect.getHeight() - 20);
                    canvas.setLineWidth(5);
                    canvas.setColorStroke(new BaseColor(218, 165, 32)); // Gold
                    canvas.rectangle(rect.getLeft(), rect.getBottom(), rect.getWidth() - 40, rect.getHeight() - 40);
                    canvas.stroke();

                    // 2. Add "Smart Assess AI" Logo (Top Left)
                    try {
                        BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                        canvas.beginText();
                        canvas.setFontAndSize(bf, 14);
                        canvas.setColorFill(new BaseColor(44, 62, 80)); // Dark Blue/Grey
                        // Coordinates: x=50 (from left), y=height-50 (from top)
                        canvas.showTextAligned(Element.ALIGN_LEFT, "Smart Assess AI", 50, rect.getHeight() - 50, 0);
                        canvas.endText();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });

            document.open();

            // --- Fonts ---
            Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 42, Font.BOLD, new BaseColor(139, 0, 0));
            Font nameFont = new Font(Font.FontFamily.TIMES_ROMAN, 34, Font.ITALIC | Font.BOLD);
            Font textFont = new Font(Font.FontFamily.TIMES_ROMAN, 20);
            Font scoreFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.DARK_GRAY);

            // --- Layout ---
            document.add(new Paragraph("\n\n")); // Initial spacing

            Paragraph title = new Paragraph("CERTIFICATE OF ACHIEVEMENT", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            document.add(new Paragraph("\n"));

            Paragraph text1 = new Paragraph("This is proudly presented to", textFont);
            text1.setAlignment(Element.ALIGN_CENTER);
            document.add(text1);

            document.add(new Paragraph("\n"));

            Paragraph studentName = new Paragraph(name, nameFont);
            studentName.setAlignment(Element.ALIGN_CENTER);
            document.add(studentName);

            // Subtle underline for the name
            Paragraph line = new Paragraph("___________________________________________", textFont);
            line.setAlignment(Element.ALIGN_CENTER);
            document.add(line);

            document.add(new Paragraph("\n"));

            Paragraph text2 = new Paragraph("For successfully completing the test on course", textFont);
            text2.setAlignment(Element.ALIGN_CENTER);
            document.add(text2);

            Paragraph courseName = new Paragraph(course, nameFont);
            courseName.setAlignment(Element.ALIGN_CENTER);
            document.add(courseName);

            document.add(new Paragraph("\n"));

            Paragraph scoreText = new Paragraph("Final Score: " + score + "%", scoreFont);
            scoreText.setAlignment(Element.ALIGN_CENTER);
            document.add(scoreText);

            document.add(new Paragraph("\n\n\n"));

            // --- Footer Table (Date and Signature) ---
            PdfPTable footerTable = new PdfPTable(2);
            footerTable.setWidthPercentage(80);
            
            PdfPCell cellDate = new PdfPCell(new Phrase("Issued on: " + java.time.LocalDate.now(), textFont));
            cellDate.setBorder(Rectangle.NO_BORDER);
            cellDate.setHorizontalAlignment(Element.ALIGN_LEFT);
            
            PdfPCell cellSig = new PdfPCell(new Phrase("Authorized Signature: 𝓢𝓪𝓱𝓲𝓽𝔂𝓲𝓴𝓪", textFont));
            cellSig.setBorder(Rectangle.NO_BORDER);
            cellSig.setHorizontalAlignment(Element.ALIGN_RIGHT);

            footerTable.addCell(cellDate);
            footerTable.addCell(cellSig);
            
            document.add(footerTable);

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
<!DOCTYPE html>
<html>
<head>
    <title>Print Specified Division</title>
    <style>
        .printable {
            display: block;
            page-break-before: always;
            page-break-after: always;
        }
    </style>
    <script>
        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            var printWindow = window.open('', '', 'width=800,height=800');
            printWindow.document.open();
            printWindow.document.write('<html><head><title>Print</title></head><body>' + printContents + '</body></html>');
            printWindow.document.close();

            printWindow.print();
            printWindow.close();

            // Restore the original content
            document.body.innerHTML = originalContents;
        }
    </script>
</head>
<body>
    <div>llllllllllllllll</div>
    nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
    <div id="printable">
        <!-- Your content to be printed goes here -->
        <h1>Printable Content</h1>
        <p>This is the content you want to print.</p>
    </div>

    <button onclick="printDiv('printable')">Print</button>
</body>
</html>

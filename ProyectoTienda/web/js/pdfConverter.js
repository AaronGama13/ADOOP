function savePDF() {
    var element = document.getElementById('htmlToPDF');
    var fecha = document.getElementById('fecha');
    var opt = {
        margin:       0.5,        
        filename:     'ReporteVenta'+fecha.textContent+'.pdf',
        image:        { type: 'jpeg', quality: 0.98 },
        html2canvas:  { scale: 2, width: 850 },
        jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' }
      };

      // New Promise-based usage:
      html2pdf().set(opt).from(element).save();
}
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/data/models/dimentions.dart';
import 'package:sana_health_t/data/models/meta.dart';

class FormProvider extends ChangeNotifier {
  // Basic controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();

  // Pricing controllers
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  // Stock controllers
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _minimumOrderController = TextEditingController();

  // Dimension controllers
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _depthController = TextEditingController();

  // Aditional information controllers
  final TextEditingController _warrantyController = TextEditingController();
  final TextEditingController _shippingController = TextEditingController();
  final TextEditingController _returnPolicyController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();

  // Image picker
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  // Selectors
  String? selectedCategory;
  String? selectedAvailability;

  final List<String> _categories = [
    'Beauty',
    'Fragrances',
    'Furniture',
    'Groceries',
  ];

  final List<String> _availabilityStatuses = [
    'In Stock',
    'Low Stock',
    'Out of Stock',
  ];

  // Getters
  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get brandController => _brandController;
  TextEditingController get skuController => _skuController;
  TextEditingController get priceController => _priceController;
  TextEditingController get discountController => _discountController;
  TextEditingController get stockController => _stockController;
  TextEditingController get minimumOrderController => _minimumOrderController;
  TextEditingController get weightController => _weightController;
  TextEditingController get widthController => _widthController;
  TextEditingController get heightController => _heightController;
  TextEditingController get depthController => _depthController;
  TextEditingController get warrantyController => _warrantyController;
  TextEditingController get shippingController => _shippingController;
  TextEditingController get returnPolicyController => _returnPolicyController;
  TextEditingController get tagsController => _tagsController;
  TextEditingController get barcodeController => _barcodeController;
  List<String> get categories => _categories;
  List<String> get availabilityStatuses => _availabilityStatuses;
  List<XFile> get selectedImages => _selectedImages;
  Product get product {
    return Product(
      id: 0,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: selectedCategory ?? '',
      price: double.tryParse(_priceController.text) ?? 0.0,
      discountPercentage: double.tryParse(_discountController.text) ?? 0.0,
      rating: 0.0,
      stock: int.tryParse(_stockController.text) ?? 0,
      tags: _parseTags(_tagsController.text),
      brand: _brandController.text.trim(),
      sku: _skuController.text.trim(),
      weight: double.tryParse(_weightController.text) ?? 0.0,
      dimensions: Dimensions(
        width: double.tryParse(_widthController.text) ?? 0.0,
        height: double.tryParse(_heightController.text) ?? 0.0,
        depth: double.tryParse(_depthController.text) ?? 0.0,
      ),
      warrantyInformation: _warrantyController.text.trim(),
      shippingInformation: _shippingController.text.trim(),
      availabilityStatus: selectedAvailability ?? 'In Stock',
      reviews: [],
      returnPolicy: _returnPolicyController.text.trim(),
      minimumOrderQuantity: int.tryParse(_minimumOrderController.text) ?? 1,
      meta: Meta(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        barcode: _barcodeController.text.trim(),
        qrCode: '',
      ),
      images: _selectedImages.map((img) => img.path).toList(),
      thumbnail: _selectedImages.isNotEmpty ? _selectedImages.first.path : '',
    );
  }

  List<String> _parseTags(String tagsText) {
    if (tagsText.trim().isEmpty) return [];
    return tagsText
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }

  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        _selectedImages.addAll(images);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _selectedImages.add(image);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error taking photo: $e');
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < _selectedImages.length) {
      _selectedImages.removeAt(index);
      notifyListeners();
    }
  }

  void clearImages() {
    _selectedImages.clear();
    notifyListeners();
  }

  void updateCategory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  void updateAvailability(String? value) {
    selectedAvailability = value;
    notifyListeners();
  }

  void clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _brandController.clear();
    _skuController.clear();
    _priceController.clear();
    _discountController.clear();
    _stockController.clear();
    _minimumOrderController.clear();
    _weightController.clear();
    _widthController.clear();
    _heightController.clear();
    _depthController.clear();
    _warrantyController.clear();
    _shippingController.clear();
    _returnPolicyController.clear();
    _tagsController.clear();
    _barcodeController.clear();
    selectedCategory = null;
    selectedAvailability = null;
    notifyListeners();
  }

  void loadProduct(Product product) {
    _titleController.text = product.title;
    _descriptionController.text = product.description;
    _brandController.text = product.brand;
    _skuController.text = product.sku;
    _priceController.text = product.price.toString();
    _discountController.text = product.discountPercentage.toString();
    _stockController.text = product.stock.toString();
    _minimumOrderController.text = product.minimumOrderQuantity.toString();
    _weightController.text = product.weight.toString();
    _widthController.text = product.dimensions.width.toString();
    _heightController.text = product.dimensions.height.toString();
    _depthController.text = product.dimensions.depth.toString();
    _warrantyController.text = product.warrantyInformation;
    _shippingController.text = product.shippingInformation;
    _returnPolicyController.text = product.returnPolicy;
    _tagsController.text = product.tags.join(', ');
    _barcodeController.text = product.meta.barcode;
    selectedCategory = product.category;
    selectedAvailability = product.availabilityStatus;
    notifyListeners();
  }

  String? basicStringValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.length < 3) {
      return 'Minimum 3 characters';
    }
    return null;
  }

  String? basicSelectorValidator(String? value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Enter a valid number';
    }
    if (number < 0) {
      return 'Must be a positive number';
    }
    return null;
  }

  String? percentageValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Campo opcional
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Enter a valid number';
    }
    if (number < 0 || number > 100) {
      return 'Must be between 0 and 100';
    }
    return null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _skuController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _stockController.dispose();
    _minimumOrderController.dispose();
    _weightController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _depthController.dispose();
    _warrantyController.dispose();
    _shippingController.dispose();
    _returnPolicyController.dispose();
    _tagsController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }
}
